require "simplecov"
SimpleCov.start do
  track_files "/lib/**/*.rb"
  add_filter "/test/"
end

if ENV["CI"] == "true"
  require "codecov"
  SimpleCov.formatter = SimpleCov::Formatter::Codecov
end

require "minitest/autorun"
require "json"
require "objectia"

module ObjectiaTest

  class Test < Minitest::Test
    def client
      @client ||= Objectia::Client.new({
        api_key: ENV["OBJECTIA_APIKEY"],
        timeout: 10,
      })
    end
  end

end