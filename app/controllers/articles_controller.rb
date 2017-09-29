
class ArticlesController < ApplicationController
  before_action :set_article, only: [:edit, :update, :show, :destroy]
  before_action :require_user, except: [:index, :show]
  before_action :require_same_user, only: [:edit, :update, :destroy]

  def index
    @articles = Article.paginate(page: params[:page], per_page: 2)
  end

  def new
    @article = Article.new
  end

  def edit
  end

  def update

    if @article.update(article_params)
      flash[:success] = "Article was successfully updated"
      redirect_to article_path(@article)
    else
      render 'edit'
    end
  end

  def create
    # render plain: params[:article].inspect
    @article = Article.new(article_params)
    @article.user = User.first
    # @article.save
    # redirect_to articles_path(@article)
    if @article.save
      flash[:success] = 'Article was succesfully created'
      redirect_to article_path(@article)
    else
      render 'new'
    end
  end

  def destroy

    @article.destroy
    flash[:danger] = "Article was successfully deleted."
    redirect_to articles_path
  end

  def show
  end

  private

  def set_article
    @article = Article.find(params[:id])
  end

  def require_same_user
    if curent_user != @article.user
      flash[:danger] = "You can only edit or delete your own article"
      redirect_to root_path
    end
  end

  def article_params
    params.require(:article).permit(:title, :description)
  end
end
