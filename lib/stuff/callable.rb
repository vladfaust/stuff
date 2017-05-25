module Stuff
  module Callable

    # Functional programming comes to Ruby :-)
    #
    # @example
    #   class Foo
    #     include Stuff::Callable
    #
    #     def call
    #       puts 'kek'
    #     end
    #   end
    #
    #   Foo.call
    #   # => 'kek'
    #

    def self.included(base)
      base.send :include, InstanceMethods
      base.class_eval do
        extend ClassMethods
      end
    end

    module InstanceMethods
      def call
        raise NotImplementedError
      end
    end

    module ClassMethods
      def call(*args, &block)
        i = self.new(*args)
        block ? (yield i) : i.call
        i
      end
    end
  end
end
