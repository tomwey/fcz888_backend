ActiveAdmin.register PromoPoster do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
permit_params :product_id, :top_img, :bottom_img, :bg_color, :btn_text, :app_url, :opened 

form do |f|
  f.semantic_errors
  f.inputs do
    f.input :product_id, as: :select, collection: LoanProduct.all.map { |o| [o.name, o.id] }
    f.input :top_img, hint: '建议尺寸，750x642'
    f.input :bg_color, placeholder: '#2d2343或rgb(255,234,213)'
    f.input :bottom_img, hint: '建议图片宽度750'
    f.input :btn_text, placeholder: '如果不填，默认为：立即借款'
    f.input :app_url
    f.input :opened
  end
  actions
end

end
