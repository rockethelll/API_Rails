class CommentsController < ApplicationController
  before_action :authenticate_user!, :set_comment, only: %i[new create show update destroy]

  def index
    @comments = Comment.all
    render json: @comments
  end

  def show
    render json: @comment
  end

  def create
    @comment = Comment.new(comment_params)

    if @comment.save
      render json: @comment, status: :created, location: @comment
    else
      render json: @comment.errors, status: :unprocessable_entity
    end
  end

  def update
    if @comment.user == current_user
      if @comment.update(comment_params)
        render json: @comment
      else
        render json: @comment.errors, status: :unprocessable_entity
      end
    else
      render json: { message: "Modification interdite. Ce n'est pas votre commentaire !" }, status: :unauthorized
    end
  end

  def destroy
    if @comment.user == current_user
      @comment.destroy
    else
      render json: { message: "Suppression interdite. Ce n'est pas votre commentaire !" }, status: :unauthorized
    end
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
