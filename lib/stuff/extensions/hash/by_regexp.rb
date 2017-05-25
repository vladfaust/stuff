module Stuff
  module Extensions
    module Hash
      module ByRegexp
        def find_by_regexp(value)
          self.find{ |k, v| k.match?(value) if k.is_a?(Regexp) }
        end

        def select_by_regexp(value)
          self.select{ |k, v| k.match?(value) if k.is_a?(Regexp) }
        end
      end
    end
  end
end
