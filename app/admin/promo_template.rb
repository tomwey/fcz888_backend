ActiveAdmin.register PromoTemplate do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name, :image
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
  column('序号',:id)
  column :name, sortable: false
  column :image, sortable: false do |o|
    image_tag o.image.url(:small)
  end
  column '创建时间', :created_at
  actions
end

end
