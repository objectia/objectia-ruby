module Objectia
  class RestClient
    include HTTParty

    def initialize(options = {})
      @api_key = options[:api_key]
      @api_base_url = options.fetch(:api_base_url) { "https://api.objectia.com/rest/v1" }   
      @timeout = options.fetch(:timeout) { 30 }   
      @user_agent =  "objectia-ruby/#{VERSION}"                   
    end

    def api_key
      if @api_key.to_s.empty?
        raise ArgumentError.new("No API key provided") 
      end
      @api_key
    end

    def get(path)
      execute("GET", path)
    end   

    def post(path, params=nil)
      execute("POST", path, params)
    end   

    def put(path, params=nil)
      execute("PUT", path, params)
    end   

    def patch(path, params=nil)
      execute("PATCH", path, params)
    end   

    def delete(path)
      execute("DELETE", path)
    end   

    def execute(method, path, params=nil)
      headers = { 
        "Authorization" => "Bearer #{api_key}", 
        "User-Agent" => "twostep-ruby/#{VERSION}", 
        "Accept" => "application/json"
      }

      begin
        case method
        when "GET"
          resp = self.class.get(path, base_uri: @api_base_url, timeout: @timeout, :headers => headers)
        when "POST"
          headers["Content-Type"] = "application/json"
          resp = self.class.post(path, base_uri: @api_base_url, timeout: @timeout, :headers => headers, :body => params.to_json)
        when "PUT"
          headers["Content-Type"] = "application/json"
          resp = self.class.put(path, base_uri: @api_base_url, timeout: @timeout, :headers => headers, :body => params.to_json)
        when "PATCH"
          headers["Content-Type"] = "application/json"
          resp = self.class.patch(path, base_uri: @api_base_url, timeout: @timeout, :headers => headers, :body => params.to_json)
        when "DELETE"  
          resp = self.class.delete(path, base_uri: @api_base_url, timeout: @timeout, :headers => headers)
        end  

        if [200,201].include?(resp.code)
          result = JSON.parse(resp.body) #FIXME: Handle 204 No content
          return result["data"]
        else  
          begin
            err = JSON.parse(resp.body)
            raise ResponseError.new(err["message"], resp.code, err["code"])
          rescue JSON::ParserError
            raise ResponseError.new(resp.message, resp.code)  # code?
          end
        end  
      rescue Timeout::Error, Net::ReadTimeout => e
        raise APITimeoutError.new(e.message)
      rescue Errno::ECONNREFUSED, Errno::EINVAL, Errno::ECONNRESET, EOFError,
        Net::HTTPBadResponse, Net::HTTPHeaderSyntaxError, Net::ProtocolError,
        HTTParty::Error, SocketError => e
        raise APIConnectionError.new(e.message)
      end
    end

  end
end  
