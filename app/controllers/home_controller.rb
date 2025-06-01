class HomeController < ApplicationController
  def index
    @top_authors = Author
                   .select('authors.*, COUNT(article_authors.id) AS articles_count')
                   .joins(:article_authors)
                   .group('authors.id')
                   .order('articles_count DESC')
                   .limit(10)
  end
end
