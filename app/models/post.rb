class Post < ActiveRecord::Base

	include VoteableHenryk

	belongs_to :creator, class_name: "User", foreign_key: "user_id"
	has_many :comments, dependent: :destroy
	has_many :post_categories
	has_many :categories, :through => :post_categories, dependent: :destroy
	has_many :votes, as: :voteable

	scope :list, -> { all.sort_by{ |x| x.total_votes }.reverse }

	validates :title, presence: true, length: {minimum: 5}
	validates :description, presence: true
	validates :url, presence: true, uniqueness: true

	before_create :generate_slug

	def generate_slug
		self.slug = self.title.gsub(/[\s\/\.\?\\]/, "-").downcase
	end

	def to_param
		self.slug
	end
end
