require 'set'
require 'hashie/mash' # gem 'hashie'

module Stuff
  module Exposures

    # Allows classes to expose its instance variables in one hash
    #
    # @example
    #   class Foo
    #     include Stuff::Exposures
    #     expose :bar
    #
    #     def call
    #       @bar = 42
    #     end
    #   end
    #
    #   foo = Foo.new.call
    #
    #   foo.bar
    #   # => 42
    #   foo.exposures[:bar]
    #   # => 42 # Again!
    #

    def self.included(base)
      base.class_eval do
        extend ClassMethods
      end
      base.include InstanceMethods
    end

    module ClassMethods
      def exposures
        @exposures ||= Set.new
      end

      # Adds variable(s) to a list of exposed ones
      # These variable(s) will have attribute readers
      #
      # @example
      #   expose :foo, :bar
      #
      def expose(*variables)
        class_eval do
          exposures.merge(variables)
          Array(variables).each do |v|
            attr_reader v
          end
        end
      end

      def inherited(subclass)
        subclass.exposures.merge(exposures)
        super
      end
    end

    module InstanceMethods
      # Returns a Mash of exposed instance variables
      #
      # @example
      #   x.exposures
      #   # => { foo: 'bar', baz: 42 }
      #
      #   x.exposures.foo
      #   # => 'bar'
      #
      def exposures
        Hashie::Mash.new(self.class.exposures.reduce({}) do |hash, variable_name|
          hash[variable_name.to_sym] = instance_variable_get("@#{ variable_name }")
          hash
        end)
      end
    end
  end
end
