class CommentsController < ApplicationController
  def create
    @comment = current_user.comments.build(comment_params)

    if @comment.save
      redirect_to request.referer
    else
      redirect_to request.referer
      flash.now[:alert] = '140字以内のコメントにしてください。'
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content, images: []).merge(post_id: params[:post_id].to_i)
  end
end
