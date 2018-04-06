class CommentsController < ApplicationController
  before_action :set_comment, only: [:edit, :update, :destroy]
  before_action :authenticate_user!
  before_action :user_consistency_check, only: [:edit, :update, :destroy]

  def edit
  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      redirect_to @comment.article, notice: 'Comment was successfully created.'
    else
      render :new
    end
  end

  def update
    if @comment.update(comment_params)
      redirect_to @comment.article, notice: 'Comment was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    article = @comment.article
    @comment.destroy

    redirect_to article, notice: 'Comment was successfully destroyed.'
  end

  private
  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:article_id, :user_id, :body)
  end

  def user_consistency_check
    if current_user != @comment.user
      flash.alert = "You're not authorized to perform that action."
      redirect_to @comment.article
    end
  end
end
