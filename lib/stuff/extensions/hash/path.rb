module Stuff
  module Extensions
    module Hash
      module Path
        def path(value)
          self.inject(nil) do |path, (k, v)|
            if v.is_a?(::Hash)
              _k = v.path(value)
              (path ||= []) << [k, _k] if _k
            else
              break k if v == value
            end

            path&.flatten
          end
        end
      end
    end
  end
end
