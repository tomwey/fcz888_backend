class PromoTemplate < ActiveRecord::Base
  validates :name, :image, presence: true
  mount_uploader :image, CoverImageUploader
end
