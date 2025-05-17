require "application_system_test_case"

class EditionsTest < ApplicationSystemTestCase
  setup do
    @edition = editions(:one)
  end

  test "visiting the index" do
    visit editions_url
    assert_selector "h1", text: "Editions"
  end

  test "should create edition" do
    visit editions_url
    click_on "New edition"

    fill_in "Access url", with: @edition.access_url
    fill_in "Available format", with: @edition.available_format
    fill_in "Doi", with: @edition.doi
    fill_in "Edition type", with: @edition.edition_type
    fill_in "Editors", with: @edition.editors
    fill_in "Publication date", with: @edition.publication_date
    fill_in "Scientific journal", with: @edition.scientific_journal_id
    fill_in "Theme", with: @edition.theme
    fill_in "Volume", with: @edition.volume
    click_on "Create Edition"

    assert_text "Edition was successfully created"
    click_on "Back"
  end

  test "should update Edition" do
    visit edition_url(@edition)
    click_on "Edit this edition", match: :first

    fill_in "Access url", with: @edition.access_url
    fill_in "Available format", with: @edition.available_format
    fill_in "Doi", with: @edition.doi
    fill_in "Edition type", with: @edition.edition_type
    fill_in "Editors", with: @edition.editors
    fill_in "Publication date", with: @edition.publication_date
    fill_in "Scientific journal", with: @edition.scientific_journal_id
    fill_in "Theme", with: @edition.theme
    fill_in "Volume", with: @edition.volume
    click_on "Update Edition"

    assert_text "Edition was successfully updated"
    click_on "Back"
  end

  test "should destroy Edition" do
    visit edition_url(@edition)
    accept_confirm { click_on "Destroy this edition", match: :first }

    assert_text "Edition was successfully destroyed"
  end
end
