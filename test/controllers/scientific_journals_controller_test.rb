require "test_helper"

class ScientificJournalsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @scientific_journal = scientific_journals(:one)
  end

  test "should get index" do
    get scientific_journals_url
    assert_response :success
  end

  test "should get new" do
    get new_scientific_journal_url
    assert_response :success
  end

  test "should create scientific_journal" do
    assert_difference("ScientificJournal.count") do
      post scientific_journals_url, params: { scientific_journal: { closure_year: @scientific_journal.closure_year, current_status: @scientific_journal.current_status, foundation_year: @scientific_journal.foundation_year, institutional_affiliation: @scientific_journal.institutional_affiliation, issn: @scientific_journal.issn, name: @scientific_journal.name, periodicity: @scientific_journal.periodicity, qualis: @scientific_journal.qualis, thematic_scope: @scientific_journal.thematic_scope, website_url: @scientific_journal.website_url } }
    end

    assert_redirected_to scientific_journal_url(ScientificJournal.last)
  end

  test "should show scientific_journal" do
    get scientific_journal_url(@scientific_journal)
    assert_response :success
  end

  test "should get edit" do
    get edit_scientific_journal_url(@scientific_journal)
    assert_response :success
  end

  test "should update scientific_journal" do
    patch scientific_journal_url(@scientific_journal), params: { scientific_journal: { closure_year: @scientific_journal.closure_year, current_status: @scientific_journal.current_status, foundation_year: @scientific_journal.foundation_year, institutional_affiliation: @scientific_journal.institutional_affiliation, issn: @scientific_journal.issn, name: @scientific_journal.name, periodicity: @scientific_journal.periodicity, qualis: @scientific_journal.qualis, thematic_scope: @scientific_journal.thematic_scope, website_url: @scientific_journal.website_url } }
    assert_redirected_to scientific_journal_url(@scientific_journal)
  end

  test "should destroy scientific_journal" do
    assert_difference("ScientificJournal.count", -1) do
      delete scientific_journal_url(@scientific_journal)
    end

    assert_redirected_to scientific_journals_url
  end
end
