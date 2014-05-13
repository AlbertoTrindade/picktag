class Image < ActiveRecord::Base
  belongs_to :user
  has_many :feedbacks, dependent: :destroy

  validates :tag, presence: true, length: { maximum: 30 }
  validates :user_id, presence: true
  validates :img, presence: true
  validates :rating, presence:true

  has_attached_file :img, styles: {
  	square: '200x200#',
  	medium: '300x300>',
  	large: '900x'
  }

  validates_attachment_content_type :img, :content_type => /\Aimage\/.*\Z/

  def self.search(tag, page)
  	Image.joins(:user).order('rating DESC, users.reputation DESC').where('tag ILIKE ?', "%#{tag}%").paginate(:per_page => 3,:page => page)
  end

  def update_rating
    relevant_count = Feedback.where(image_id: self.id, relevant: true).count
    irrelevant_count = Feedback.where(image_id: self.id, relevant: false).count

    new_rating = relevant_count.to_f/(relevant_count + irrelevant_count)
    new_rating = new_rating*10
    self.update_attribute(:rating, new_rating)
  end
end
