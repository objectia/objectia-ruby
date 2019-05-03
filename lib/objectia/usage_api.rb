module Objectia
  class UsageAPI

    def initialize(rest_client)
      @rest_client = rest_client
    end  

    def get()
      return @rest_client.get("/usage")
    end  

  end
end    