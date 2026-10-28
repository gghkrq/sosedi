module Admin
  class ArticlesController < BaseController
    before_action :set_article, only: %i[ edit update destroy ]

    def index
      @articles = Article.newest
    end

    def new
      @article = Article.new
    end

    def create
      @article = Article.new(article_params)
      if @article.save
        redirect_to admin_articles_path, notice: "Статья опубликована."
      else
        render :new, status: :unprocessable_content
      end
    end

    def edit
    end

    def update
      if @article.update(article_params)
        redirect_to admin_articles_path, notice: "Статья обновлена.", status: :see_other
      else
        render :edit, status: :unprocessable_content
      end
    end

    def destroy
      @article.destroy!
      redirect_to admin_articles_path, notice: "Статья удалена.", status: :see_other
    end

    private

    def set_article
      @article = Article.find(params.expect(:id))
    end

    def article_params
      params.expect(article: [ :title, :category, :summary, :body ])
    end
  end
end
