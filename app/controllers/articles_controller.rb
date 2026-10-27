class ArticlesController < ApplicationController
  def index
    @articles = Article.newest
  end
end
