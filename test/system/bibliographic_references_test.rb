require "application_system_test_case"

class BibliographicReferencesTest < ApplicationSystemTestCase
  setup do
    @bibliographic_reference = bibliographic_references(:one)
  end

  test "visiting the index" do
    visit bibliographic_references_url
    assert_selector "h1", text: "Bibliographic references"
  end

  test "should create bibliographic reference" do
    visit bibliographic_references_url
    click_on "New bibliographic reference"

    fill_in "Doi", with: @bibliographic_reference.doi
    fill_in "Language", with: @bibliographic_reference.language
    fill_in "Publication location", with: @bibliographic_reference.publication_location
    fill_in "Publisher", with: @bibliographic_reference.publisher
    fill_in "Reference type", with: @bibliographic_reference.reference_type
    fill_in "Title", with: @bibliographic_reference.title
    fill_in "Year", with: @bibliographic_reference.year
    click_on "Create Bibliographic reference"

    assert_text "Bibliographic reference was successfully created"
    click_on "Back"
  end

  test "should update Bibliographic reference" do
    visit bibliographic_reference_url(@bibliographic_reference)
    click_on "Edit this bibliographic reference", match: :first

    fill_in "Doi", with: @bibliographic_reference.doi
    fill_in "Language", with: @bibliographic_reference.language
    fill_in "Publication location", with: @bibliographic_reference.publication_location
    fill_in "Publisher", with: @bibliographic_reference.publisher
    fill_in "Reference type", with: @bibliographic_reference.reference_type
    fill_in "Title", with: @bibliographic_reference.title
    fill_in "Year", with: @bibliographic_reference.year
    click_on "Update Bibliographic reference"

    assert_text "Bibliographic reference was successfully updated"
    click_on "Back"
  end

  test "should destroy Bibliographic reference" do
    visit bibliographic_reference_url(@bibliographic_reference)
    accept_confirm { click_on "Destroy this bibliographic reference", match: :first }

    assert_text "Bibliographic reference was successfully destroyed"
  end
end
