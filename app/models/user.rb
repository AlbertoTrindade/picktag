class User < ActiveRecord::Base
  has_many :images, dependent: :destroy
  has_many :feedbacks, dependent: :destroy

  before_save { email.downcase! }
  before_create :create_remember_token

  validates :name, presence: true, length: { maximum: 50 }
  VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-]+(?:\.[a-z\d\-]+)*\.[a-z]+\z/i
  validates :email, presence: true, format: { with: VALID_EMAIL_REGEX },
                    uniqueness: { case_sensitive: false }
  validates :reputation, presence:true
  has_secure_password
  validates :password, length: { minimum: 8 }

  def User.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def User.new_remember_token
    SecureRandom.urlsafe_base64
  end

  def User.hash(token)
    Digest::SHA1.hexdigest(token.to_s)
  end

  def update_reputation
    relevant_count = 0
    irrelevant_count = 0

    self.images.each do |i|  
      relevant_count = relevant_count + Feedback.where(image_id: i.id, relevant: true).count 
    end

    self.images.each do |i|  
      irrelevant_count = irrelevant_count + Feedback.where(image_id: i.id, relevant: false).count 
    end

    new_reputation = relevant_count.to_f/(relevant_count + irrelevant_count)
    new_reputation = new_reputation*10
    self.update_attribute(:reputation, new_reputation)
  end

  private

    def create_remember_token
      self.remember_token = User.hash(User.new_remember_token)
    end
end
