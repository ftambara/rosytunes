require "application_system_test_case"

class FindingAlbumsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  test "searching for an album" do
    sign_in(users(:one))
    visit root_path

    click_on "Search"
    click_on "Albums"
    fill_in ".searchbox", with: "Appetite for Destruction"
    click_on "Search"

    find(".album").find(".artist", text: "Guns N' Roses").click_link

    assert_select(".h2", text: "Guns N' Roses")
  end
end
