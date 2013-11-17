class Category < ActiveRecord::Base
	has_many :post_categories
	has_many :posts, :through => :post_categories, dependent: :destroy

	validates :name, presence: true

	before_create :generate_slug

	def generate_slug
		self.slug = self.name.gsub(/[\s\/\.\?\\]/, "-").downcase
	end

	def to_param
		self.slug
	end
end
