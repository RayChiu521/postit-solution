class CommentsController < ApplicationController
	def create
		@post = Post.find_by(slug: params[:post_id])
		@comment = @post.comments.build(params.require(:comment).permit(:body))
		@comment.creator = current_user

		if @comment.save
			flash[:notice] = "Your comment has been created."
			redirect_to post_path(@post)
		else
			render "posts/show"
		end
	end

	def vote
		@comment = Comment.find(params[:id])
		@vote = @comment.votes.create(vote: params[:vote], creator: current_user)

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
end
