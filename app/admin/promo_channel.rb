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
  column 'PV/UV' do |o|
    raw("PV: #{o.today_pv}/#{o.total_pv}<br>UV: #{o.today_uv}/#{o.total_uv}")
  end
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

show do
  attributes_table do
    row :uniq_id
    row :name
    row :mobile
    row :private_token
    row :opened
    row :created_at
  end
  panel 'PV/UV统计' do
    render 'stats', { channel: promo_channel }
  end
end

end
