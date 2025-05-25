require "application_system_test_case"

class AuthorsTest < ApplicationSystemTestCase
  setup do
    @author = authors(:one)
  end

  test "visiting the index" do
    visit authors_url
    assert_selector "h1", text: "Authors"
  end

  test "should create author" do
    visit authors_url
    click_on "New author"

    fill_in "Academic background", with: @author.academic_background
    fill_in "Country of origin", with: @author.country_of_origin
    fill_in "Institutional affiliation", with: @author.institutional_affiliation
    fill_in "Name", with: @author.name
    fill_in "Specialization area", with: @author.specialization_area
    click_on "Create Author"

    assert_text "Author was successfully created"
    click_on "Back"
  end

  test "should update Author" do
    visit author_url(@author)
    click_on "Edit this author", match: :first

    fill_in "Academic background", with: @author.academic_background
    fill_in "Country of origin", with: @author.country_of_origin
    fill_in "Institutional affiliation", with: @author.institutional_affiliation
    fill_in "Name", with: @author.name
    fill_in "Specialization area", with: @author.specialization_area
    click_on "Update Author"

    assert_text "Author was successfully updated"
    click_on "Back"
  end

  test "should destroy Author" do
    visit author_url(@author)
    accept_confirm { click_on "Destroy this author", match: :first }

    assert_text "Author was successfully destroyed"
  end
end
