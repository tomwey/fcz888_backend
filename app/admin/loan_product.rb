ActiveAdmin.register LoanProduct do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name, :logo, :min_money, :max_money, :min_length, :max_length, :length_type, :intro, :speed, :pass_rate, :loan_rate, :body, :body_url, :opened_at, :sort, { tags: [] }, { conditions: [] }
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
  column('#',:id)
  column :uniq_id, sortable: false
  column '产品信息' do |o|
    raw("<img src='#{o.logo.url(:normal)}'><p>#{o.name}</p>")
  end
  column '借款额度' do |o|
    o.loan_money
  end
  column '借款期限' do |o|
    o.loan_duration
  end
  column '贷款利率' do |o|
    o.format_loan_rate
  end
  column '贷款审批通过率' do |o|
    o.format_pass_rate
  end
  column '放款速度' do |o|
    o.loan_speed
  end
  column :intro, sortable: false
  # column :body_url, sortable: false
  column '所属标签' do |o|
    o.tag_names.join(',')
  end
  column '申请条件' do |o|
    raw(o.condition_names.join('<br>'))
  end
  column :opened_at
  column :sort
  column '创建时间', :created_at
  
  actions
end

form do |f|
  f.semantic_errors
  f.inputs '基本信息' do
    f.input :name, placeholder: '输入贷款产品名字'
    f.input :logo
    f.input :min_money, placeholder: '输入金额，单位元'
    f.input :max_money, hint: '如果只有一个额度时，那么该值保持和最小额度一致', placeholder: '输入金额，单位元'
    f.input :length_type, as: :radio, collection: LoanProduct::LENGTH_TYPEs
    f.input :min_length, placeholder: '输入最小借款期限，整数'
    f.input :max_length, hint: '如果只有一个借款期限，那么该值填最小借款期限', placeholder: '输入最大借款期限，整数'
    f.input :loan_rate, as: :number, hint: '该字段与借款期限类型有关系，如果借款期限是按天计算，那么表示日利率，如果是按月计算，那么表示月利率', placeholder: '输入贷款利率，单位%'
    f.input :pass_rate, as: :number, placeholder: '输入贷款审批通过率，单位%'
    f.input :speed, as: :select, collection: LoanSpeed.all.map { |s| [s.name, s.score] }
    f.input :body_url, placeholder: '输入产品推广链接地址', hint: '必须是全地址超链接，例如：http://www.baidu.com'
    f.input :body, as: :text, input_html: { class: 'redactor' }, placeholder: '网页内容，支持图文混排', hint: '网页内容，支持图文混排'
    f.input :intro, placeholder: '一句话介绍该产品'
    f.input :tags, as: :check_boxes, collection: Tag.all.map { |t| [t.name, t.id] }
    f.input :conditions, as: :check_boxes, collection: LoanCondition.all.map { |t| [t.name, t.id] }
    f.input :opened_at, as: :string, placeholder: '例如：2019-03-19 12:30', hint: '可选，如果不填，表示立即上线'
    f.input :sort, hint: '值越大，显示越靠前'
    # f.input :body, as: :text, input_html: { class: 'redactor' }, placeholder: '网页内容，支持图文混排', hint: '网页内容，支持图文混排'
  end
  actions
end

end

# t.string :name, null: false, default: ''
# t.string :logo, null: false
# t.integer :min_money, null: false
# t.integer :max_money, null: false
# t.integer :min_length, null: false
# t.integer :max_length, null: false
# t.integer :length_type, null: false
# t.string :intro
# t.integer :speed
# t.integer :tags, array: true, default: []
# t.string :pass_rate
# t.string :loan_rate
# t.integer :loan_rate_type
# t.string :body_url
# t.text :body
# t.integer :view_count, default: 0
# t.integer :order_count, default: 0
# t.datetime :opened_at
# t.datetime :deleted_at
# t.integer :sort, default: 0
