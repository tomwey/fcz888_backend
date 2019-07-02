ActiveAdmin.register PromoEvent do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name, { channel_ids: [] }, :promo_template_id, { promo_product_ids: [] }, :opened
#
# or
#
# permit_params do
#   permitted = [:permitted, :attributes]
#   permitted << :other if params[:action] == 'create' && current_user.admin?
#   permitted
# end

index do
  selectable_column
  column :id
  column '广告封面', sortable: false do |o|
    o.promo_template ? image_tag(o.promo_template.image.url(:small), size: '80x142') : ''
  end
  column :uniq_id, sortable: false
  column :name, sortable: false
  column '推广的产品', sortable: false do |o|
    html = ''
    o.promo_products.each do |p|
      html += p.name + '<br>'
    end
    raw(html)
  end
  column '渠道链接', sortable: false do |o|
    html = ''
    o.channels.each do |c|
      html += "<p><strong>#{c.name}</strong>: #{c.share_url(o)}</p>"
    end
    raw(html)
  end
  column '浏览数', :view_count
  column '点击数', :take_count
  # column :mobile, sortable: false
  column :created_at
  actions
end

form do |f|
  f.semantic_errors
  f.inputs '基本信息' do
    f.input :name, placeholder: '输入活动名字'
    f.input :promo_template_id, as: :select, collection: PromoTemplate.all.map { |pt| [pt.name, pt.id] }
    f.input :promo_product_ids, as: :check_boxes, required: true, collection: LoanProduct.where(opened: true).map { |t| [t.name, t.id] }
    f.input :channel_ids, as: :check_boxes, required: true, collection: PromoChannel.where(opened: true).map { |t| [t.name, t.id] }
    f.input :opened
  end
  actions
end

end
