# frozen_string_literal: true

class ArticlesController < ApplicationController
  before_action :authenticate_user!, :set_article, only: %i[new create show update destroy]

  def index
    @articles = Article.all

    render json: @articles
  end

  def show
    render json: @article
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      render json: @article, status: :created, location: @article
    else
      render json: @article.errors, status: :unprocessable_entity
    end
  end

  def update
    if @article.user == current_user
      if @article.update(article_params)
        render json: @article
      else
        render json: @article.errors, status: :unprocessable_entity
      end
    else
      render json: { message: "Modification interdite. Ce n'est pas votre article !" }, status: :unauthorized
    end
  end

  def destroy
    if @article.user == current_user
      @article.destroy
    else
      render json: { message: "Suppression interdite.Ce n'est pas votre article !" }, status: :unauthorized
    end
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :content, :user_id)
  end
end
