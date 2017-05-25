module Stuff
  module Callable
    module Failures

      # Adds #success? & #failure? instance methods as long as private #fail!.
      #
      # When #fail! is called, interrupts the execution of a callable and adds an argument to @error attribute
      #

      def self.included(base)
        base.class_eval do
          extend ClassMethods
          attr_reader :error
        end
        base.send :include, InstanceMethods
      end

      module ClassMethods
        # Failures should be included after Callable
        #
        def call(*args, &block)
          catch :failure do
            super
          end
        end
      end

      module InstanceMethods
        def success?
          !@failure
        end
        alias_method :success, :success?

        def failure?
          !!@failure
        end
        alias_method :failure, :failure?

        private

        # Interrupts the execution
        #
        # @params
        #   error [Object] (Optional) Will be set as .error attribute
        #
        # @example
        #   fail!(:a_error)
        #
        def fail!(error = nil)
          @failure = true
          @error = error
          throw :failure, self
        end
      end
    end
  end
end
