require "test_helper"

class ArticlesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @article = articles(:one)
  end

  test "should get index" do
    get articles_url
    assert_response :success
  end

  test "should get new" do
    get new_article_url
    assert_response :success
  end

  test "should create article" do
    assert_difference("Article.count") do
      post articles_url,
           params: { article: { abstract: @article.abstract, article_url: @article.article_url, authors: @article.authors,
                                data_source: @article.data_source, database_citation: @article.database_citation, datings: @article.datings, doi: @article.doi, edition_id: @article.edition_id, institutions: @article.institutions, laboratory_methods: @article.laboratory_methods, language: @article.language, main_methodology: @article.main_methodology, publication_type: @article.publication_type, research_theme: @article.research_theme, spatial_analysis: @article.spatial_analysis, states: @article.states, title: @article.title } }
    end

    assert_redirected_to article_url(Article.last)
  end

  test "should show article" do
    get article_url(@article)
    assert_response :success
  end

  test "should get edit" do
    get edit_article_url(@article)
    assert_response :success
  end

  test "should update article" do
    patch article_url(@article),
          params: { article: { abstract: @article.abstract, article_url: @article.article_url, authors: @article.authors,
                               data_source: @article.data_source, database_citation: @article.database_citation, datings: @article.datings, doi: @article.doi, edition_id: @article.edition_id, institutions: @article.institutions, laboratory_methods: @article.laboratory_methods, language: @article.language, main_methodology: @article.main_methodology, publication_type: @article.publication_type, research_theme: @article.research_theme, spatial_analysis: @article.spatial_analysis, states: @article.states, title: @article.title } }
    assert_redirected_to article_url(@article)
  end

  test "should destroy article" do
    assert_difference("Article.count", -1) do
      delete article_url(@article)
    end

    assert_redirected_to articles_url
  end
end
