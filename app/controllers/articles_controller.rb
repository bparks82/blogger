class ArticlesController < ApplicationController
  #include Kernel
  before_filter :require_login, :except => [:index, :show]
  
  def index
    @articles = Article.all
  end

  def show
    @article = Article.find(params[:id])
    #audit @article.inspect
  end

  def new
    @article = Article.new
  end

  def create
   #legit way
   # @article = Article.new(params[:article])
   #bush-league way
    @article = Article.new(:title => params[:article][:title],
                           :tag_list => params[:article][:tag_list],
                           :body => params[:article][:body])
    @article.save

    redirect_to article_path(@article)
  end

  def destroy
    @article = Article.find(params[:id])
    #audit @article.inspect
    @article.destroy

    redirect_to articles_path
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    @article.update_attributes(params[:article])
    #audit @article.inspect
    flash[:message] = "Article '#{@article.title}' Updated!"

    redirect_to article_path(@article)
  end
end
