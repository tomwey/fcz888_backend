# require 'rest-client'
require "rack/user_agent"
module API
  module V1
    class FczAPI < Grape::API
      
      helpers API::SharedParams
      
      resource :app, desc: '跟APP全局配置相关的接口' do
        desc "获取配置"
        get :configs do
          { code: 0, message: 'ok', data: { card_url: SiteConfig.credit_query_url } }
        end # end configs
      end # end resource 
      
      resource :home, desc: '首页相关接口' do
        desc "获取贷款产品"
        params do
          optional :token, type: String, desc: "用户登录TOKEN"
        end
        get :products do
          @products = LoanProduct.where(deleted_at: nil, opened: true).where.not(opened_at: nil).order('sort desc, id desc').limit(10)
          
          suggest = LoanProduct.where(deleted_at: nil).where.not(opened_at: nil).order('RANDOM()').limit(1)
          { code: 0, message: 'ok', data: {
            products: API::V1::Entities::LoanProduct.represent(@products),
            suggest: API::V1::Entities::LoanProduct.represent(suggest)
          }}
        end # end get products
      end # end resource home
      
      resource :loan, desc: '大额贷款申请' do
        desc "贷款申请"
        params do
          requires :token, type: String, desc: "用户登录TOKEN"
        end
        post :apply do
          user = authenticate!
          apply = LoanApply.new(user_id: user.id)
          params.each do |k,v|
            if apply.has_attribute?(k.to_sym)
              apply.send "#{k}=", v
            end
          end
          
          if apply.save
            render_json_no_data
          else
            render_error(5000, '提交失败了！')
          end
          
        end # end post apply
      end # end resource
      
      resource :products, desc: '贷款产品相关接口' do
        desc "获取产品列表"
        params do
          optional :token, type: String, desc: "用户登录TOKEN"
          optional :money, type: String, desc: "贷款金额查询，值为：-3000,3000-12000,12000-"
          optional :loan_type, type: Integer, desc: '借款方式：1 按天借，2 按月借'
          optional :sort, type: String, desc: '排序方式：，字段+排序，例如：pass_rate,desc'
          use :pagination
        end
        get do
          @products = LoanProduct.where(deleted_at: nil, opened: true).where.not(opened_at: nil)
          if params[:money].present?
            if !params[:money].include?('-')
              return render_error(-1, '不正确的money参数')
            end
            
            moneys = params[:money].split('-')
            if moneys.size < 1 || moneys.size > 2
              return render_error(-1, '不正确的money参数')
            end
            
            if moneys.size == 1
              money = moneys[0].to_i
            elsif moneys.size == 2
              m1 = moneys[0].to_i
              m2 = moneys[1].to_i
              if m1 != 0 and m2 != 0
                money = [m1,m2].min
              elsif m1 == 0 and m2 != 0
                money = m2
              elsif m1 != 0 and m2 == 0
                money = m1
              else
                money = 0
              end
            else
              money = 0
            end
            if money > 0
              @products = @products.where('min_money <= :money and max_money >= :money', {money: money})
            end
            
          end
          if params[:loan_type].present?
            if not [1,2].include?(params[:loan_type])
              return render_error(-1, '不正确的loan_type参数')
            end
            @products = @products.where(length_type: params[:loan_type])
          end
          if params[:sort].present?
            if !params[:sort].include?(',')
              return render_error(-1, '不正确的sort参数')
            end
            @products = @products.order(params[:sort].gsub(',', ' '))
          else
            @products = @products.order('sort desc')
          end
          
          if params[:page]
            @products = @products.paginate page: params[:page], per_page: page_size
            total = @products.total_entries
          else
            total = @products.size
          end
          render_json(@products, API::V1::Entities::LoanProductDetail, {}, total)
        end # end get
        desc "获取某个产品详情"
        params do
          optional :token, type: String, desc: "用户登录TOKEN"
          requires :id,  type: Integer, desc: "产品ID"
        end
        get '/:id/body' do
          @product = LoanProduct.where(deleted_at: nil, opened: true, uniq_id: params[:id]).where.not(opened_at: nil).first
          if @product.blank?
            return render_error(4004, '该贷款不存在')
          end
          
          @product.view_count += 1
          @product.save
          
          render_json(@product, API::V1::Entities::LoanProductDetail)
        end # end get body
        
      end # end resource products
      
      resource :cards, desc: '信用卡相关接口' do
        desc "获取银行"
        params do
          optional :token, type: String, desc: "用户登录TOKEN"
        end
        get :banks do
          @banks = Bank.order('sort desc')
          render_json(@banks, API::V1::Entities::Bank)
        end # end get banks
        desc "获取信用卡"
        params do
          optional :token, type: String, desc: "用户登录TOKEN"
          optional :bank_ids,type: String, desc: "所属银行，多个ID用逗号分隔"
          use :pagination
        end
        get do
          @cards = CreditCard.where(opened: true).order('sort desc')
          if params[:bank_ids].present?
            @cards = @cards.where(bank_id: params[:bank_ids].split(','))
          end
          
          if params[:page]
            @cards = @cards.paginate page: params[:page], per_page: page_size
            total = @cards.total_entries
          else
            total = @cards.size
          end
          render_json(@cards, API::V1::Entities::CreditCard, {}, total)
        end # end get cards
      end # end resource cards
      
      resource :event, desc: '推广活动相关接口' do
        desc "获取活动详情"
        params do
          # requires :id, type: Integer, desc: '活动ID'
         #  requires :cid, type: Integer, desc: '渠道ID'
         requires :key, type: String, desc: '活动或其他相关信息'
        end
        get do
          string = EncryptUtils.decode(SiteConfig.enc_key, SiteConfig.enc_dec_key, params[:key])
          if string.blank?
            return render_error(-1, '不正确的key参数')
          end
          id = string.split('|')[0]
          cid = string.split('|')[1]
          @event = PromoEvent.find_by(uniq_id: id, opened: true)
          if @event.blank?
            return render_error(4004, '推广活动不存在')
          end
          @channel = PromoChannel.where(opened: true, uniq_id: cid).first
          if @channel.blank?
            return render_error(4004, '渠道不存在')
          end
          
          unless @event.channel_ids.include? @channel.id
            return render_error(4000, '渠道无该活动访问权限')
          end
          
          render_json(@event, API::V1::Entities::PromoEvent)
        end # end get
        
        desc "活动或产品追踪"
        params do
          # requires :id, type: Integer, desc: '活动ID'
          # requires :cid, type: Integer, desc: '渠道ID'
          requires :key, type: String, desc: '活动或其他相关信息'
          requires :action, type: String, desc: '操作行为'
          optional :pid, type: Integer, desc: '产品ID'
        end
        post :log do
          string = EncryptUtils.decode(SiteConfig.enc_key, SiteConfig.enc_dec_key, params[:key])
          if string.blank?
            return render_error(-1, '不正确的key参数')
          end
          id = string.split('|')[0]
          cid = string.split('|')[1]
          @event = PromoEvent.find_by(uniq_id: id, opened: true)
          if @event.blank?
            return render_error(4004, '推广活动不存在')
          end
          @channel = PromoChannel.where(opened: true, uniq_id: cid).first
          if @channel.blank?
            return render_error(4004, '渠道不存在')
          end
          
          unless @event.channel_ids.include? @channel.id
            return render_error(4000, '渠道无该活动访问权限')
          end
          if params[:pid].present?
            # 统计产品点击
            product = LoanProduct.find_by(uniq_id: params[:pid], opened: true)
            if product
              LoanProductTrack.create(event_id: @event.id, channel_id: @channel.id, product_id: product.id, ip: client_ip, user_agent: request.user_agent, os: request.os, os_version: request.os_version)
            end
          else
            # 统计活动事件
            if params[:action] == 'view'
              PromoEventTrack.create!(promo_event_id: @event.id, promo_channel_id: @channel.id, action:  params[:action], ip: client_ip, user_agent: request.user_agent, os: request.os, os_version: request.os_version)
              @event.view_count += 1
              @event.save!
            elsif params[:action] == 'click'
              PromoEventTrack.create!(promo_event_id: @event.id, promo_channel_id: @channel.id, action:  params[:action], ip: client_ip, user_agent: request.user_agent, os: request.os, os_version: request.os_version)
              @event.take_count += 1
              @event.save!
            else
              return render_error(5000, '不支持的action')
            end
          end
          render_json_no_data
        end
      end # end resource
      
    end
  end
end