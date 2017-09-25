class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]

  def index
    @articles = Article.all
  end

  def new
    @article = Article.new
  end

  def edit

  end

  def update

    if @article.update(article_params)
      flash[:notice] = "Article was successfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def create
    # render plain: params[:article].inspect
    @article = Article.new(article_params)
    # @article.save
    # redirect_to articles_path(@article)
    if @article.save
      flash[:notice] = 'Article was succesfully created'
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def destroy

    @article.destroy
    flash[:notice] = "Article was successfully deleted."
    redirect_to articles_path
  end

  def show

  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end
end
