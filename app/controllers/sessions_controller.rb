class SessionsController < ApplicationController

	skip_before_action :require_user, only: [:new, :create, :pin]

	def new
	end

	def create
		user = User.find_by_username(params[:username])
		if user && user.authenticate(params[:password])
			if user.two_factor_auth?
				session[:two_factor] = user.id
				user.generate_pin!
				user.send_pin_to_twilio
				redirect_to pin_path
			else
				login_user(user)
			end
		else
			flash[:error] = "There's something wrong with your username or password."
			redirect_to login_path
		end
	end

	def pin
		if request.post?
			user = User.find_by(id: session[:two_factor], pin: params[:pin])
			if user
				session[:two_factor] = nil?
				login_user(user)
			else
				flash[:error] = "Sorry, something was wrong with that pin!"
				redirect_to pin_path
			end
		end
	end

	def destroy
		session[:user_id] = nil
		flash[:notice] = "You've logged out."
		redirect_to root_path
	end

	private
		def login_user(user)
			session[:user_id] = user.id
			flash[:notice] = "You've' logged in."
			redirect_to root_path
		end

end