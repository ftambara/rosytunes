ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "minitest/mock"

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
    def attribute_not_nil_test(model, attribute)
      assert_not_nil model.send(attribute)
    end

    def attribute_not_empty_test(model, attribute)
      assert_not_empty model.send(attribute)
    end

    def can_have_one_test(model, collection, related_model)
      can_have_many_test(model, collection, [related_model])
    end

    def can_have_many_test(model, collection, related_models)
      related_models.each do |related_model|
        model.send(collection) << related_model
      end
      assert_equal related_models.length, model.send(collection).count
    end
  end
end

VCR.configure do |config|
  config.cassette_library_dir = "test/cassettes"
  config.hook_into :webmock
end
