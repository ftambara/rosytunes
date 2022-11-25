require "application_system_test_case"

class FindingAlbumsTest < ApplicationSystemTestCase
  include Devise::Test::IntegrationHelpers

  test "can add and delete a bookmark when logged in" do
    user = users(:one)
    sign_in(user)
    visit artist_path(artists(:guns_n_roses))

    click_on "Save"
    click_on "#{user.name}'s profile"
    assert ".album", count: 1

    click_on "Unsave", wait: 20
    assert ".album", count: 0
  end
end
