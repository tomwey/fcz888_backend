class PromoEvent < ActiveRecord::Base
  validates :name, presence: true
  
  belongs_to :promo_template
  
  validate :array_not_empty
  def array_not_empty
    self.channel_ids = self.channel_ids.compact.reject(&:blank?)
    self.promo_product_ids = self.promo_product_ids.compact.reject(&:blank?)
    
    if self.promo_product_ids.empty?
      errors.add(:promo_product_ids, '不能为空')
      return false
    end
    
    if self.channel_ids.empty?
      # puts 123
      errors.add(:channel_ids, '不能为空')
      return false
    end
    
    
  end
  
  before_create :generate_unique_id
  def generate_unique_id
    begin
      n = rand(10)
      if n == 0
        n = 8
      end
      self.uniq_id = (n.to_s + SecureRandom.random_number.to_s[2..6]).to_i
    end while self.class.exists?(:uniq_id => uniq_id)
  end
  
  before_save :remove_blank_value_for_array
  def remove_blank_value_for_array
    self.channel_ids = self.channel_ids.compact.reject(&:blank?)
    self.promo_product_ids = self.promo_product_ids.compact.reject(&:blank?)
  end
  
  def promo_products
    @promo_products ||= LoanProduct.where(id: promo_product_ids, opened: true, deleted_at: nil).order('sort desc,id desc')
  end
  
end
