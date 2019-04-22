class RemoveProductNullLimitForPromoPosters < ActiveRecord::Migration
  def change
    change_column_null :promo_posters, :product_id, true
  end
end
