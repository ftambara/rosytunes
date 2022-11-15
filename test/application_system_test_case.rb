require "test_helper"

VCR.configure do |config|
  config.allow_http_connections_when_no_cassette = true
end
class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]
end
