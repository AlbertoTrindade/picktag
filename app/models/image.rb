class Image < ActiveRecord::Base
  belongs_to :user
  validates :tag, presence: true, length: { maximum: 30 }
  validates :user_id, presence: true

  has_attached_file :img, styles: {
  	square: '200x200#',
  	medium: '300x300>',
  	large: '900x'
  }

  validates_attachment_content_type :img, :content_type => /\Aimage\/.*\Z/
end
