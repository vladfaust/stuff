require 'sequel' # gem 'sequel'
require 'connection_pool' # gem 'connection_pool'

module Stuff
  module Sequel
    class DBPool
      DEFAULT_POOL_SIZE = 20.freeze # Per 1 process

      attr_reader :db

      def initialize(
        url = ENV['DATABASE_URL'],
        max_connections: DEFAULT_POOL_SIZE,
        extensions:,
        log_level: :info
      )
        options = {
          max_connections: max_connections,
        }

        @db = ::Sequel.connect(url, options)
        extensions.each{ |e| @db.extension e }
        @db.sql_log_level = log_level

        @db
      end

      def shutdown
        @db.disconnect
      end

      # def [](args)
      #   @db.[](args)
      # end

      def finalize(id)
        shutdown
      end

      def method_missing(m, *args, &block)
        @db.send(m, *args, &block)
      end
    end
  end
end
