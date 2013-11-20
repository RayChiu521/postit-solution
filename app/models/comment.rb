class Comment < ActiveRecord::Base

	include Voteable

	belongs_to :creator, class_name: "User", foreign_key: "user_id"
	belongs_to :post
	has_many :votes, as: :voteable

	scope :list, -> { all.sort_by{ |x| x.total_votes }.reverse }

	validates :body, presence: true
end
