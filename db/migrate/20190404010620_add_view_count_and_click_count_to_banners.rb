class AddViewCountAndClickCountToBanners < ActiveRecord::Migration
  def change
    add_column :banners, :view_count, :integer, default: 0
    add_column :banners, :click_count, :integer, default: 0
  end
end
