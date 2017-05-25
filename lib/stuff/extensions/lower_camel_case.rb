module Stuff
  module Extensions
    module LowerCamelCase
      def self.included(base)
        ::String.include(String)
        ::Symbol.include(Symbol)
        ::Hash.include(Hash)
      end

      module String
        def lower_camel_case
          split('_').map.with_index{ |w, i| i == 0 ? w : w.capitalize }.join
        end

        def lower_camel_case!
          replace(lower_camel_case)
        end
      end

      module Symbol
        def lower_camel_case
          to_s.lower_camel_case.to_sym
        end
      end

      module Hash
        def lower_camel_case_keys
          self.inject({}){ |memo, (k, v) | memo[k.lower_camel_case] = v; memo }
        end

        def lower_camel_case_keys!
          replace(lower_camel_case_keys)
        end

        def deep_lower_camel_case_keys
          self.inject({}){ |h, (k, v)| h[k.lower_camel_case] = v.is_a?(::Hash) ? v.deep_lower_camel_case_keys : v; h }
        end

        def deep_lower_camel_case_keys!
          replace(deep_lower_camel_case_keys)
        end
      end
    end
  end
end
