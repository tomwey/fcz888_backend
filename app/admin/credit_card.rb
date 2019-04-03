ActiveAdmin.register CreditCard do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :bank_id, :cover, :name, :intro, :special, :apply_url, :view_count, :sort, :apply_count, :opened

index do
  selectable_column
  column('#',:id)
  column :cover do |o|
    image_tag o.cover.url(:thumb)
  end
  column :name
  column '所属银行' do |o|
    o.bank.try(:name)
  end
  column :intro
  column :special
  column :apply_url do |o|
    o.apply_url.blank? ? '' : link_to('点击打开', o.apply_url, target: '_blank')
  end
  column :view_count
  column :apply_count
  column :sort
  column :opened
  column '创建时间', :created_at
  
  actions
end

form do |f|
  f.semantic_errors
  f.inputs '基本信息' do
    f.input :bank_id, as: :select, collection: Bank.all.map { |b| [b.name, b.id] }, required: true
    f.input :name, placeholder: '信用卡名字'
    f.input :cover
    f.input :apply_url
    f.input :intro, placeholder: '一句话介绍信用卡'
    f.input :special
    f.input :view_count
    f.input :apply_count
    f.input :sort
    f.input :opened
  end
  actions
end

end

# t.integer :bank_id, null: false
# t.string :cover, null: false
# t.string :name, null: false
# t.string :intro
# t.string :special
# t.string :apply_url, null: false
# t.integer :view_count, default: 0
# t.integer :sort, default: 0
# t.integer :apply_count, default: 0
# t.boolean :opened, default: true
