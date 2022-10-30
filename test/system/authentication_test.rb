require "application_system_test_case"

class AuthenticationTest < ApplicationSystemTestCase
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

  test "a user can sign in and then sign out" do
    visit root_path

    click_on "Sign in"
    fill_in "user_email", with: users(:one).email
    fill_in "user_password", with: "wisecracker"

    click_on "Sign in"

    assert_in_home_page

    click_on "Sign out"
    
    assert_in_home_page
  end

  def assert_in_home_page
    assert_selector ".welcome"
  end
end
