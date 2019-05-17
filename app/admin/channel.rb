ActiveAdmin.register Channel do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name, :poster_id, :opened
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
  column :name
  column '营销模板注册页面' do |o|
    o.promo_poster.try(:name) || o.promo_poster.id
  end
  column :opened
  column :created_at
  actions
end

form do |f|
  f.semantic_errors
  f.inputs '基本信息' do
    f.input :name
    f.input :poster_id, as: :select, collection: PromoPoster.all.map { |o| [o.uniq_id, o.id] }
    f.input :opened
  end
  actions
end

end
