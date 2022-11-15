require "application_system_test_case"

class FindingAlbumsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  test "searching for an album" do
    visit root_path

    select "Albums", from: "Entity"
    fill_in "Query", with: "Appetite For Destruction"

    click_on "Search"
    sleep(10)

    find(".album_card", match: :first).click_link
  end
end
