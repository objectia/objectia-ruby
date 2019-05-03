require_relative "./helper"

module ObjectiaTest
  class ObjectiaClientTest < ObjectiaTest::Test

    def test_no_api_key
      assert_raises ArgumentError do
        cli = Objectia::Client.new({
          api_key: "",
        })
        _ = cli.api_key
      end
    end

    def test_get_api_usage
      usage = client.usage.get()
      print usage["geoip_requests"]
      #assert_equal "111", usage["geoip_requests"]
      #assert_equal "123456", usage.id 
    end

  end
end