require "test_helper"

class SiteLayoutTest < ActionDispatch::IntegrationTest
  test "navbar links" do
    get root_path
    assert_select "a[href=?]", root_path, count: 1
    skip "Missing session links tests"
  end
end
