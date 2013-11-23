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

	def two_factor_auth?
		!self.phone.blank?
	end

	def generate_pin!
		self.update_column(:pin, rand(10 ** 6))
	end

	def send_pin_to_twilio
		if two_factor_auth?
			account_sid = 'AC80ca93af8ffa3f3fd84057bf617edc79'
			auth_token = '550c1817c09c441ec229e16b5f2b5560'

			# set up a client to talk to the Twilio REST API
			client = Twilio::REST::Client.new(account_sid, auth_token)

			msg = "Hello, to proceed with your login, please input pin: #{self.pin}"

			account = client.account
			message = account.sms.messages.create({:from => '+14243320731', :to => self.phone, :body => msg})
		end
	end
end
