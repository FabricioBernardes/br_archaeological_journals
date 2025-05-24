require "test_helper"

class BibliographicReferencesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @bibliographic_reference = bibliographic_references(:one)
  end

  test "should get index" do
    get bibliographic_references_url
    assert_response :success
  end

  test "should get new" do
    get new_bibliographic_reference_url
    assert_response :success
  end

  test "should create bibliographic_reference" do
    assert_difference("BibliographicReference.count") do
      post bibliographic_references_url, params: { bibliographic_reference: { authors: @bibliographic_reference.authors, doi: @bibliographic_reference.doi, language: @bibliographic_reference.language, publication_location: @bibliographic_reference.publication_location, publisher: @bibliographic_reference.publisher, reference_type: @bibliographic_reference.reference_type, title: @bibliographic_reference.title, year: @bibliographic_reference.year } }
    end

    assert_redirected_to bibliographic_reference_url(BibliographicReference.last)
  end

  test "should show bibliographic_reference" do
    get bibliographic_reference_url(@bibliographic_reference)
    assert_response :success
  end

  test "should get edit" do
    get edit_bibliographic_reference_url(@bibliographic_reference)
    assert_response :success
  end

  test "should update bibliographic_reference" do
    patch bibliographic_reference_url(@bibliographic_reference), params: { bibliographic_reference: { authors: @bibliographic_reference.authors, doi: @bibliographic_reference.doi, language: @bibliographic_reference.language, publication_location: @bibliographic_reference.publication_location, publisher: @bibliographic_reference.publisher, reference_type: @bibliographic_reference.reference_type, title: @bibliographic_reference.title, year: @bibliographic_reference.year } }
    assert_redirected_to bibliographic_reference_url(@bibliographic_reference)
  end

  test "should destroy bibliographic_reference" do
    assert_difference("BibliographicReference.count", -1) do
      delete bibliographic_reference_url(@bibliographic_reference)
    end

    assert_redirected_to bibliographic_references_url
  end
end
