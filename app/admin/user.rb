ActiveAdmin.register User do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
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
  column :uid, sortable: false
  column :name, sortable: false
  column :idcard, sortable: false
  column '注册渠道' do |o|
    o.channel.try(:name)
  end
  column :created_at
  column '银行信息' do |o|
    raw("银行卡号: #{o.bank_no}<br>银行预留手机: #{o.bank_mobile}<br>开卡信息: #{o.bank_info}")
  end
  column :private_token, sortable: false
  column :verified, sortable: false
  actions
end


end
