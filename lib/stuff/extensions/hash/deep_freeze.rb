module Stuff
  module Extensions
    module Hash
      module DeepFreeze
        def deep_freeze
          each{ |k, v| v.deep_freeze if v.respond_to?(:deep_freeze) }
          freeze
        end
      end
    end
  end
end
