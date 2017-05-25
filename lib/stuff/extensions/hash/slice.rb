module Stuff
  module Extensions
    module Hash
      module Slice
        def slice(*keys)
          ::Hash[[keys, self.values_at(*keys)].transpose].compact
        end

        def slice!(*keys)
          self.replace(slice(*keys))
        end
      end
    end
  end
end
