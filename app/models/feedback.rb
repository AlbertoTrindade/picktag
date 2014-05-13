class Feedback < ActiveRecord::Base
	belongs_to :user
	belongs_to :image

	validates_inclusion_of :relevant, :in => [true, false]
end
