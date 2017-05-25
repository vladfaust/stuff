require 'redis' # gem 'redis'
require 'connection_pool' # gem 'connection_pool'

module Stuff
  class RedisPool
    DEFAULT_POOL_SIZE = 100.freeze # Per 1 process

    def initialize(
      url = ENV['REDIS_URL'],
      size: ENV['MAX_REDIS_CONNECTIONS'].to_i,
      timeout: 5
    )
      @pool = ConnectionPool.new(size: size | DEFAULT_POOL_SIZE, timeout: timeout) do
        self.class.single_connection(url)
      end
    end

    def self.single_connection(url = ENV['REDIS_URL'])
      url ? ::Redis.new(url: url) : ::Redis.new
    end

    # Closes all the connections and clears the pool
    #
    def shutdown
      @pool.shutdown do |connection|
        connection.quit
      end
    end

    # Gets a connection from pool and yields a given &block
    #
    # @example
    #   Stuff::RedisPool.new.connect { |connection| connection.get('key') }
    #
    def connect(&block)
      @pool.with do |connection|
        yield connection
      end
    end

    def method_missing(m, *args)
      connect do |c|
        c.send(m, *args)
      end
    end

    private

    def finalize(id)
      shutdown
    end
  end
end
