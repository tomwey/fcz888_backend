class AddNameToPromoPosters < ActiveRecord::Migration
  def change
    add_column :promo_posters, :name, :string
  end
end
