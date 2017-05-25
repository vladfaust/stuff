module Stuff
  module Callable
    module Hooks

      # Adds nifty before, after & around hooks, which are evaulated in instance context
      #
      # Extracted from https://github.com/collectiveidea/interactor/blob/master/lib/interactor/hooks.rb
      #
      # @example
      #   class Foo
      #     include Stuff::Hooks
      #
      #     before do
      #       self.bar
      #     end
      #     before :baz # Can use either block or method name(s) as an argument
      #     before :foobar # Chainable!
      #
      #     around do |instance|
      #       instance.foobarbaz
      #     end
      #   end
      #

      def self.included(base)
        base.class_eval do
          extend ClassMethods
        end
        base.send :include, InstanceMethods
      end

      module ClassMethods
        def wrap_in_hooks(instance)
          instance.with_hooks do
            instance.call
          end
        end

        # Overrides or adds a class #call method.
        #
        # Hooks module is independent from Callable, but if included both, Hooks should be included later in order to hooks to work:
        #
        #   module A
        #     include Stuff::Callable
        #     include Stuff::Hooks
        #   end
        #
        def call(*args)
          if defined?(super)
            super{ |i| wrap_in_hooks(i) }
          else
            wrap_in_hooks(self.new(*args))
          end
        end

        def before(*hooks, &block)
          hooks << block if block
          hooks.each{ |hook| before_hooks.push(hook) }
        end

        def around(*hooks, &block)
          hooks << block if block
          hooks.each{ |hook| around_hooks.push(hook) }
        end

        def after(*hooks, &block)
          hooks << block if block
          hooks.each{ |hook| after_hooks.unshift(hook) }
        end

        def before_hooks
          @before_hooks ||= []
        end

        def around_hooks
          @around_hooks ||= []
        end

        def after_hooks
          @after_hooks ||= []
        end
      end

      module InstanceMethods
        def with_hooks
          run_around_hooks do
            run_before_hooks
            yield
            run_after_hooks
          end
        end

        def run_around_hooks(&block)
          self.class.around_hooks.reverse.inject(block){ |chain, hook|
            proc{ run_hook(hook, chain) }
          }.call
        end

        def run_before_hooks
          run_hooks(self.class.before_hooks)
        end

        def run_after_hooks
          run_hooks(self.class.after_hooks)
        end

        def run_hooks(hooks)
          hooks.each{ |hook| run_hook(hook) }
        end

        def run_hook(hook, *args)
          hook.is_a?(Symbol) ? send(hook, *args) : instance_exec(*args, &hook)
        end
      end
    end
  end
end
