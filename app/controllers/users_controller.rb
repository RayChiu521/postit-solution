class UsersController < ApplicationController

	before_action :set_user, only: [:show, :edit, :update, :destroy]
	skip_before_action :require_user, only: [:new, :create]

	def new
		@user = User.new
	end

	def create
		@user = User.new(user_params)

		if @user.save
			flash[:notice] = 'User was created.'
			redirect_to root_path
		else
			render 'new'
		end
	end

	def show
		@posts = @user.posts.list
		@comments = @user.comments.list
	end

	def edit
	end

	def update
		if @user.update(user_params)
			flash[:notice] = "User profile was udpated."
			redirect_to root_path
		else
			render 'edit'
		end
	end

	def destroy
		if @user.destroy
			flash[:notice] = "User was destroyed."
			redirect_to root_path
		else
			render 'show'
		end
	end

	private

	def user_params
		params.require(:user).permit(:username, :password)
	end

	def set_user
		@user = User.find(params[:id])
	end
end