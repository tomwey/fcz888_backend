ActiveAdmin.register Bank do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :icon, :name, :phone, :products_url, :home_url, :sort
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
  column :icon do |o|
    image_tag o.icon.url(:large), size: '28x28'
  end
  column :name
  column :products_url do |o|
    o.products_url.blank? ? '' : link_to('点击打开', o.products_url, target: '_blank')
  end
  column :home_url do |o|
    o.home_url.blank? ? '' : link_to('点击打开', o.home_url, target: '_blank')
  end
  column :phone
  column :sort
  column '创建时间', :created_at
  
  actions
end

end
