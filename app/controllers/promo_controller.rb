class PromoController < ApplicationController
  layout 'promo'
  
  def poster
    @poster = PromoPoster.where(opened: true, uniq_id: params[:id]).first
    
  end
end
