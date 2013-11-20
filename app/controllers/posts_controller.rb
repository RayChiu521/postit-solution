class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :vote]
	before_action :require_modifiable, only: [:edit, :update, :destroy]
  skip_before_action :require_user, only: [:index, :show]

  helper_method :can_modify?

  def index
    @posts = Post.list
    respond_to do |format|
      format.html
      format.json { render json: @posts }
      format.xml { render xml: @posts }
    end
  end

  def show
    @comment = Comment.new
    @comments = @post.comments.list
  end

  def new
  	@post = Post.new
  end

  def create
    @post = current_user.posts.build(post_params)

  	if @post.save
  		flash[:notice] = "Your post was created."
  		redirect_to posts_path
  	else
  		render "new"
  	end
  end

  def edit
  end

  def update
  	if @post.update(post_params)
  		flash[:notice] = "This post was updated."
  		redirect_to posts_path
  	else
  		render "edit"
  	end
  end

  def vote
    @vote = @post.votes.create(vote: params[:vote], creator: current_user)

    if @vote.valid?
      flash[:notice] = "Your vote was counted."
    else
      flash[:error] = "You can only vote for <strong>that</strong> once.".html_safe
    end

    respond_to do |format|
      format.html { redirect_to :back }
      format.js
    end
  end

  private

  def post_params
  	params.require(:post).permit(:title, :url, :description, category_ids: [])
  end

  def set_post
  	@post = Post.find_by(slug: params[:id])
  end

  def can_modify?
    (is_admin? or (current_user and @post and @post.creator == current_user))
  end

  def require_modifiable
    access_denied unless can_modify?
  end
end
