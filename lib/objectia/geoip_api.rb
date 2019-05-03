module Objectia
  class GeoLocationAPI

    def initialize(rest_client)
      @rest_client = rest_client
    end  

    def get(ip)
      return @rest_client.get("/geoip/%s" % ip)
    end  

  end
end    