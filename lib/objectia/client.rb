module Objectia
  class Client
    ##
    # A client for accessing the Objectia API.

    def initialize(options = {})
      @rest_client = Objectia::REST.new(options) 
      @usage_api = Objectia::UsageAPI.new(@rest_client)
      @geoip_api = Objectia::GeoLocationAPI.new(@rest_client)
      @mail_api = Objectia::MailAPI.new(@rest_client)
    end

    def api_key
      @rest_client.api_key
    end

    def version()
      VERSION
    end

    def usage()
      @usage_api
    end

    def geoip()
      @geoip_api
    end

    def mail()
      @mail_api
    end

  end
end