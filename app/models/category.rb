class Category < ActiveRecord::Base
	has_many :post_categories
	has_many :posts, :through => :post_categories, dependent: :destroy

	validates :name, presence: true
end
