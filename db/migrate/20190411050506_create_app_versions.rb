class CreateAppVersions < ActiveRecord::Migration
  def change
    create_table :app_versions do |t|
      t.string :version, null: false
      t.text :change_log, null: false
      t.string :os, null: false
      t.string :app_file
      t.string :app_download_url
      t.string :bundle_id#, null: false
      t.boolean :must_upgrade, default: false
      t.boolean :opened, default: false

      t.timestamps null: false
    end
    add_index :app_versions, :version
  end
end
