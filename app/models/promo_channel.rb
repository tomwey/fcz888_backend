class PromoChannel < ActiveRecord::Base
  has_secure_password
  
  validates :name, presence: true
  validates :mobile, presence: true, format: { with: /\A1[3|4|5|6|8|7|9][0-9]\d{4,8}\z/ }
  validates_uniqueness_of :mobile
  validates :password, length: { minimum: 6 }, allow_nil: true
  
  before_create :generate_unique_id
  def generate_unique_id
    begin
      n = rand(10)
      if n == 0
        n = 8
      end
      self.uniq_id = (n.to_s + SecureRandom.random_number.to_s[2..6]).to_i
    end while self.class.exists?(:uniq_id => uniq_id)
    self.private_token = SecureRandom.uuid.gsub('-', '')
  end
end
