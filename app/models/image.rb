class Image < ActiveRecord::Base
  belongs_to :user
  default_scope -> { order('created_at DESC') }
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
  	where('tag ILIKE ?', "%#{tag}%").paginate(:per_page => 5,:page => page)
  end

end
