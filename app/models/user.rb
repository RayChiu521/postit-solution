class User < ActiveRecord::Base
	has_many :posts, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :votes

	has_secure_password validations: false

	validates :username, presence: true, uniqueness: true
	validates :password, presence: true, on: :create

	before_create :generate_slug

	def generate_slug
		self.slug = self.username.gsub(/[\s\/\.\?\\]/, "-").downcase
	end

	def to_param
		self.slug
	end
end
