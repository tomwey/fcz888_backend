ActiveAdmin.register LoanSpeed do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :name, :score
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
  f.inputs do
    f.input :name, placeholder: '例如：最快1分钟放款'
    f.input :score, hint: '分值越低，放款越快，该值可以控制贷款产品的放款速度'
    # f.input :memo, placeholder: '选填'
  end
  actions
end

end
