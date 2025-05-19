require "application_system_test_case"

class ArticlesTest < ApplicationSystemTestCase
  setup do
    @article = articles(:one)
  end

  test "visiting the index" do
    visit articles_url
    assert_selector "h1", text: "Articles"
  end

  test "should create article" do
    visit articles_url
    click_on "New article"

    fill_in "Abstract", with: @article.abstract
    fill_in "Article url", with: @article.article_url
    fill_in "Authors", with: @article.authors
    fill_in "Bibliographic reference", with: @article.bibliographic_reference
    fill_in "Data source", with: @article.data_source
    fill_in "Database citation", with: @article.database_citation
    fill_in "Datings", with: @article.datings
    fill_in "Doi", with: @article.doi
    fill_in "Edition", with: @article.edition_id
    fill_in "Institutions", with: @article.institutions
    fill_in "Laboratory methods", with: @article.laboratory_methods
    fill_in "Language", with: @article.language
    fill_in "Main methodology", with: @article.main_methodology
    fill_in "Publication type", with: @article.publication_type
    fill_in "Research theme", with: @article.research_theme
    check "Spatial analysis" if @article.spatial_analysis
    fill_in "States", with: @article.states
    fill_in "Title", with: @article.title
    click_on "Create Article"

    assert_text "Article was successfully created"
    click_on "Back"
  end

  test "should update Article" do
    visit article_url(@article)
    click_on "Edit this article", match: :first

    fill_in "Abstract", with: @article.abstract
    fill_in "Article url", with: @article.article_url
    fill_in "Authors", with: @article.authors
    fill_in "Bibliographic reference", with: @article.bibliographic_reference
    fill_in "Data source", with: @article.data_source
    fill_in "Database citation", with: @article.database_citation
    fill_in "Datings", with: @article.datings
    fill_in "Doi", with: @article.doi
    fill_in "Edition", with: @article.edition_id
    fill_in "Institutions", with: @article.institutions
    fill_in "Laboratory methods", with: @article.laboratory_methods
    fill_in "Language", with: @article.language
    fill_in "Main methodology", with: @article.main_methodology
    fill_in "Publication type", with: @article.publication_type
    fill_in "Research theme", with: @article.research_theme
    check "Spatial analysis" if @article.spatial_analysis
    fill_in "States", with: @article.states
    fill_in "Title", with: @article.title
    click_on "Update Article"

    assert_text "Article was successfully updated"
    click_on "Back"
  end

  test "should destroy Article" do
    visit article_url(@article)
    accept_confirm { click_on "Destroy this article", match: :first }

    assert_text "Article was successfully destroyed"
  end
end
