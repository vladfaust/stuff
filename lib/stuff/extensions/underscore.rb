module Stuff
  module Extensions
    module Underscore
      def self.included(base)
        ::String.include(String)
        ::Symbol.include(Symbol)
        ::Hash.include(Hash)
      end

      module String
        def underscore
          gsub(/([^A-Z])([A-Z]+)/, '\1_\2').downcase
        end

        def underscore!
          replace(underscore)
        end
      end

      module Symbol
        def underscore
          to_s.underscore.to_sym
        end
      end

      module Hash
        def underscore_keys
          self.inject({}){ |memo, (k, v) | memo[k.underscore] = v; memo }
        end

        def underscore_keys!
          replace(underscore_keys)
        end

        def deep_underscore_keys
          self.inject({}){ |h, (k, v)| h[k.underscore] = v.is_a?(::Hash) ? v.deep_underscore_keys : v; h }
        end

        def deep_underscore_keys!
          replace(deep_underscore_keys)
        end
      end
    end
  end
end
