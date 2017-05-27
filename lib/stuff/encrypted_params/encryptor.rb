require 'encrypted_strings' # gem 'encrypted_strings'

require 'json'

module Stuff
  module EncryptedParams
    class Encryptor
      attr_accessor :payload

      def initialize(secret, payload = nil)
        @secret = secret
        @payload = payload
      end

      def encrypt
        @payload = @payload.to_json.encrypt(:symmetric, password: @secret)
      end

      def decrypt
        @payload = JSON.parse(@payload.decrypt(:symmetric, password: @secret))
      end
    end
  end
end
