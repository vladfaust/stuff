module Stuff
  module Extensions
    module Pascalize
      def self.included(base)
        ::String.include(String)
        ::Symbol.include(Symbol)
        ::Hash.include(Hash)
      end

      module String
        def pascalize
          split('_').map(&:capitalize).join
        end

        def pascalize!
          replace(pascalize)
        end
      end

      module Symbol
        def pascalize
          to_s.pascalize.to_sym
        end
      end

      module Hash
        def pascalize_keys
          self.inject({}){ |memo, (k, v) | memo[k.pascalize] = v; memo }
        end

        def pascalize_keys!
          replace(pascalize_keys)
        end

        def deep_pascalize_keys
          self.inject({}){ |h, (k, v)| h[k.pascalize] = v.is_a?(::Hash) ? v.deep_pascalize_keys : v; h }
        end

        def deep_pascalize_keys!
          replace(deep_pascalize_keys)
        end
      end
    end
  end
end
