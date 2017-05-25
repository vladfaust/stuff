require 'singleton'

module Stuff
  module StaticMethods
    def self.included(base)
      base.include Singleton
      base.class_eval do
        extend ClassMethods
      end
    end

    module ClassMethods
      def method_missing(m, *args)
        instance.send(m, *args)
      end
    end
  end
end
