ActiveAdmin.register AppVersion do
# See permitted parameters documentation:
# https://github.com/activeadmin/activeadmin/blob/master/docs/2-resource-customization.md#setting-up-strong-parameters
#
# permit_params :list, :of, :attributes, :on, :model
permit_params :version, :os, :change_log, :app_file, :app_download_url, :opened, :must_upgrade, :bundle_id
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
  column('ID',:id)
  column '版本号', :version
  column '平台', :os
  column '是否必须升级' do |o|
    o.must_upgrade ? '是' : '否'
  end
  column '是否使用该版本' do |o|
    o.opened ? '是' : '否'
  end
  column 'at', :created_at
  
  actions
end

form do |f|
  f.semantic_errors
  f.inputs '版本信息' do
    f.input :version, label: '版本号', placeholder:'1.2.0'
    f.input :os, as: :select, label: '平台', collection: ['iOS', 'Android']
    # f.input :change_log, as: :text, label: '版本更新日志', rows: 10, cols: 30#, input_html: { class: 'redactor' }, placeholder: '网页内容，支持图文混排', hint: '网页内容，支持图文混排'
    f.input :bundle_id, label: 'Bundle ID/包名'
    f.input :change_log, as: :text, input_html: { class: 'redactor' }, placeholder: '网页内容，支持图文混排', hint: '网页内容，支持图文混排'
    f.input :app_file, as: :file, label: '下载安装包', hint: '格式为apk或ipa'
    f.input :app_download_url, label: 'App下载地址', placeholder: 'http://'
    f.input :must_upgrade, as: :boolean, label: '该版本是否必须升级'
    f.input :opened, as: :boolean, label: '是否上线该版本'
  end
  actions
end

end
