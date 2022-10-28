require "application_system_test_case"

class RegistrationTest < ApplicationSystemTestCase
  test "a new visitor can sign up" do
    visit root_path

    click_on "Sign up"
    fill_in "user_name", with: "name"
    fill_in "user_email", with: "new_email@example.com"
    fill_in "user_password", with: "wisecracker"
    fill_in "user_password_confirmation", with: "wisecracker"
    click_on "Sign up"
    
    assert_in_home_page
  end

  def assert_in_home_page
    assert_selector ".welcome"
  end
end
