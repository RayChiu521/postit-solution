class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments
	has_many :posts_categories
	has_many :categories, :through => :posts_categories
end
