require_relative 'encryptor'

module Stuff
  module EncryptedParams
    class Middleware
      def initialize(app, secret)
        @app = app
        @secret = secret
      end

      def call(env)
        req = Rack::Request.new(env)
        if req.params['_']
          payload = Encryptor.new(@secret, req.params['_'].gsub(' ', '+')).decrypt
          payload.each{ |k, v| req.update_param k, v }
          req.delete_param('_')
        end
        @app.call(env)
      end
    end
  end
end
