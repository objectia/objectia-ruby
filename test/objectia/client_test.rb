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

    def test_get_version
      v = client.version()
      assert_equal Objectia::VERSION, v
    end

    def test_get_api_usage
      usage = client.usage.get()
      #print "Number of GeoLocation requests:", usage["geoip_requests"]
      assert_operator usage["geoip_requests"], :>, 0
    end

    def test_get_geolocation
      location = client.geoip.get("8.8.8.8")
      assert_equal "US", location["country_code"]
    end

    def test_get_geolocation_with_options
      opts = { "fields" => "country_code" }
      location = client.geoip.get("8.8.8.8", opts)
      assert_equal "US", location["country_code"]
    end

    def test_get_bulk_geolocation
      begin
        locations = client.geoip.get_bulk(["8.8.8.8","google.com"])
        # locations.each {|loc| puts "Country code: #{loc["country_code"]}" }
        assert_equal 2, locations.length
      rescue Objectia::ResponseError => e
        if e.code == "err-invalid-ip"
          # Handle error...
        else
          # Other error...
        end
      end  
    end
  

    def test_send_mail
      message = {
        "from" => "ok@demo2.org",
        "to" => ["ok@demo2.org"],
        "subject" => "Ruby test",
        "text" => "This is a test from Ruby",
        "tags" => ["tag1", "tag2"],
        "attachments" => ["/Users/otto/me.png"]
      }
      begin
        receipt = client.mail.send(message)
        assert_equal 1, receipt["accepted_recipients"]
      rescue Objectia::ResponseError => e
        assert(false)
      end    
    end

  end
end