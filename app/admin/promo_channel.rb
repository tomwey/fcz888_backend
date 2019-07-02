ActiveAdmin.register PromoChannel do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name, :mobile, :password, :password_confirmation, :opened
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
  column :uniq_id, sortable: false
  column :name, sortable: false
  column :mobile, sortable: false
  column :created_at
  actions
end

form do |f|
  f.semantic_errors
  f.inputs '基本信息' do
    f.input :name
    f.input :mobile
    f.input :password, placeholder: '密码至少6位'
    f.input :password_confirmation, placeholder: '密码至少6位'
    f.input :opened
  end
  actions
end

end
