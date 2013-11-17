class CategoriesController < ApplicationController

  skip_before_action :require_user, only: [:show]
  before_action :require_admin, only: [:new, :create]

	def new
		@category = Category.new
	end

	def create
		@category = Category.new(params.require(:category).permit(:name))

		if @category.save
			flash[:notice] = "Category was created"
			redirect_to posts_path
		else
			render "new"
		end
	end

	def show
		@category = Category.find_by(slug: params[:id])
	end
end