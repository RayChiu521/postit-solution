class Category < ActiveRecord::Base

	include SluggableHenryk

	has_many :post_categories
	has_many :posts, :through => :post_categories, dependent: :destroy

	validates :name, presence: true

	sluggable_column :name
end
