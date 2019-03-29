class AddSortToTags < ActiveRecord::Migration
  def change
    add_column :tags, :sort, :integer, default: 0
    add_index :tags, :sort
  end
end
