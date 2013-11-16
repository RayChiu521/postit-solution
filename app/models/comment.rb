class Comment < ActiveRecord::Base
	belongs_to :creator, class_name: "User", foreign_key: "user_id"
	belongs_to :post
	has_many :votes, as: :voteable

	scope :list, -> { all.sort_by{ |x| Vote.total_votes(x) }.reverse }

	validates :body, presence: true
end
