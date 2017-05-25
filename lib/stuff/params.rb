require 'hashie/mash' # gem 'hashie'

module Stuff
  module Params

    # Makes all passed hash values instance variables
    #
    # @example
    #   class Foo
    #     include Stuff::Params
    #
    #     def bar
    #       puts @baz
    #     end
    #   end
    #
    #   Foo.new(baz: '42').bar
    #   # => '42'
    #
    #   # It's shiny cool when combinated with Callable:
    #
    #   class Foo
    #     include Stuff::Callable
    #     include Stuff::Params
    #
    #     def call
    #       puts @baz
    #     end
    #   end
    #
    #   Foo.(baz: 42)
    #   # => 42 # Awesome!
    #

    def self.included(base)
      base.include InstanceMethods
    end

    module InstanceMethods
      def initialize(params = {})
        @params = Hashie::Mash.new(params)
        params.each do |k, v|
          instance_variable_set("@#{ k }", v)
        end
      end

      def params
        @params
      end
    end
  end
end
