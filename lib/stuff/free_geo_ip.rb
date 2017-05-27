require 'httparty' # gem 'httparty'

module Stuff
  class FreeGeoIP
    include HTTParty
    base_uri ENV['FREE_GEO_IP_URI'] || 'https://freegeoip.net'

    def parse(what)
      response = self.class.get("/json/#{ what.to_s }")
      response.parsed_response
    end

    def country_code_for_ip(ip)
      parse(ip.to_s)['country_code']&.downcase
    end
  end
end
