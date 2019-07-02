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
