module Objectia
  class Client
    ##
    # A client for accessing the Objectia API.

    def initialize(options = {})
      @rest_client = Objectia::RestClient.new(options) 
      @usage_api = Objectia::UsageAPI.new(@rest_client)
      @geoip_api = Objectia::GeoLocationAPI.new(@rest_client)
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

    # def create_user(email, phone, country_code, send_install_link=false)
    #   data = {
    #     email: email, 
    #     phone: phone, 
    #     country_code: country_code, 
    #     send_install_link: send_install_link
    #   }
    #   resp = post("/users", data)
    #   user = User.new(resp.data.to_h) 
    #   user
    # end

    # def get_user(user_id)
    #   resp = get("/users/#{user_id}")
    #   user = User.new(resp.data.to_h) 
    #   user
    # end

    # def request_sms(user_id, force=false)
    #   data = {
    #     force: force
    #   }
    #   resp = post("/users/#{user_id}/sms", data) 
    #   sms = Sms.new(resp.data.to_h) 
    #   sms
    # end

    # def request_call(user_id, force=false)
    #   data = {
    #     force: force
    #   }
    #   resp = post("/users/#{user_id}/call", data)    
    #   call = Call.new(resp.data.to_h) 
    #   call
    # end

    # def remove_user(user_id)
    #   resp = delete("/users/#{user_id}")
    #   user = User.new(resp.data.to_h) 
    #   user
    # end

  end
end