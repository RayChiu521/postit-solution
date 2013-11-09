class Post < ActiveRecord::Base
	belongs_to :creator, class_name: "User", foreign_key: "user_id"
	has_many :comments, dependent: :destroy
	has_many :post_categories
	has_many :categories, :through => :post_categories, dependent: :destroy

	validates :title, presence: true, length: {minimum: 5}
	validates :description, presence: true
	validates :url, presence: true, uniqueness: true
end
