ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  # Run tests in parallel with specified workers
  parallelize(workers: :number_of_processors)

  # Setup all fixtures in test/fixtures/*.yml for
  # all tests in alphabetical order.
  fixtures :all

  # Add more helper methods to be used by all tests here...
end

module CommonTests
  module Model
    def attribute_not_empty_test(model, attribute)
      model.send("#{attribute}=", "")
      assert_not model.valid?
    end

    def can_have_one_test(model, collection, related_model)
      can_have_many_test(model, collection, [related_model])
    end

    def can_have_many_test(model, collection, related_models)
      related_models.each do |rm|
        model.send(collection) << rm
      end
      assert_equal related_models.length, model.send(collection).count
    end
  end
end

VCR.configure do |config|
  config.allow_http_connections_when_no_cassette = true
  config.cassette_library_dir = "test/cassettes"
  config.hook_into :webmock
end

# https://gist.github.com/mattbrictson/72910465f36be8319cde?permalink_comment_id=3769898#gistcomment-3769898
module WithVCR
  private
    def with_expiring_vcr_cassette(name: nil, &block)
      cassette_path = (name) ? name : _name_from_class_name(self.class.name)
      VCR.use_cassette(cassette_path) do |cassette|
        _remove_if_stale(cassette.file)
        _yield_and_clean_if_error(cassette, &block)
      end
    end

    def _name_from_class(class_name)
      names = class_name.split("::")
      cassette_path = names.map do |s|
        s.gsub(/[^A-Z0-9]+/i, "_")
      end.join("/")
    end

    def _remove_if_stale(file)
      if File.exist?(file)
        age = Time.current - File.mtime(file)
        FileUtils.rm(file) if age > 60 * 60 * 24 * 30
      end
    end

    def _yield_and_clean_if_error(cassette)
      yield(cassette)
    rescue StandardError
      FileUtils.rm(cassette.file) if File.exist?(cassette.file)
      raise
    end
end
