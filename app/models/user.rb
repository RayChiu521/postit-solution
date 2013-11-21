class User < ActiveRecord::Base

	include SluggableHenryk

	has_many :posts, dependent: :destroy
	has_many :comments, dependent: :destroy
	has_many :votes

	has_secure_password validations: false

	validates :username, presence: true, uniqueness: true
	validates :password, presence: true, on: :create

	sluggable_column :username

	def admin?
		self.role.to_s.to_sym == :admin
	end
end
