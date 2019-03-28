ActiveAdmin.register Banner do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :title, :image, :sort, :opened, :link, { page_types: [] }
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
  column 'ID', :uniq_id
  column :title
  column '封面图' do |o|
    image_tag o.image.url(:small)
  end
  column '链接' do |o|
    o.is_link? ? link_to('打开链接', o.link) : o.link
  end
  column 'at', :created_at
  actions
end

form html: { multiple: true } do |f|
  f.semantic_errors
  f.inputs do
    f.input :image, hint: '图片尺寸建议为：1080x504'
    f.input :page_types, as: :check_boxes, collection: [['首页',1], ['贷款板块', 2], ['信用卡板块',3]], required: true
    f.input :link, placeholder: '如果不填，那么此Banner广告不可点击'
    f.input :title
    f.input :sort, hint: '值越大显示越靠前'
    f.input :opened
  end
  actions
end

end
