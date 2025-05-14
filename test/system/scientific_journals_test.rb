require "application_system_test_case"

class ScientificJournalsTest < ApplicationSystemTestCase
  setup do
    @scientific_journal = scientific_journals(:one)
  end

  test "visiting the index" do
    visit scientific_journals_url
    assert_selector "h1", text: "Scientific journals"
  end

  test "should create scientific journal" do
    visit scientific_journals_url
    click_on "New scientific journal"

    fill_in "Closure year", with: @scientific_journal.closure_year
    fill_in "Current status", with: @scientific_journal.current_status
    fill_in "Foundation year", with: @scientific_journal.foundation_year
    fill_in "Institutional affiliation", with: @scientific_journal.institutional_affiliation
    fill_in "Issn", with: @scientific_journal.issn
    fill_in "Name", with: @scientific_journal.name
    fill_in "Periodicity", with: @scientific_journal.periodicity
    fill_in "Qualis", with: @scientific_journal.qualis
    fill_in "Thematic scope", with: @scientific_journal.thematic_scope
    fill_in "Website url", with: @scientific_journal.website_url
    click_on "Create Scientific journal"

    assert_text "Scientific journal was successfully created"
    click_on "Back"
  end

  test "should update Scientific journal" do
    visit scientific_journal_url(@scientific_journal)
    click_on "Edit this scientific journal", match: :first

    fill_in "Closure year", with: @scientific_journal.closure_year
    fill_in "Current status", with: @scientific_journal.current_status
    fill_in "Foundation year", with: @scientific_journal.foundation_year
    fill_in "Institutional affiliation", with: @scientific_journal.institutional_affiliation
    fill_in "Issn", with: @scientific_journal.issn
    fill_in "Name", with: @scientific_journal.name
    fill_in "Periodicity", with: @scientific_journal.periodicity
    fill_in "Qualis", with: @scientific_journal.qualis
    fill_in "Thematic scope", with: @scientific_journal.thematic_scope
    fill_in "Website url", with: @scientific_journal.website_url
    click_on "Update Scientific journal"

    assert_text "Scientific journal was successfully updated"
    click_on "Back"
  end

  test "should destroy Scientific journal" do
    visit scientific_journal_url(@scientific_journal)
    accept_confirm { click_on "Destroy this scientific journal", match: :first }

    assert_text "Scientific journal was successfully destroyed"
  end
end
