module Stuff
  module Extensions
    module Array
      module DeepFreeze
        def deep_freeze
          each{ |e| e.deep_freeze if e.respond_to?(:deep_freeze) }
          freeze
        end
      end
    end
  end
end
