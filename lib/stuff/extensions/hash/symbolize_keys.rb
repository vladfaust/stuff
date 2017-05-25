module Stuff
  module Extensions
    module Hash
      module SymbolizeKeys
        def symbolize_keys
          self.inject({}){ |memo, (k, v) | memo[k.to_sym] = v; memo }
        end

        def symbolize_keys!
          replace(symbolize_keys)
        end

        def deep_symbolize_keys
          self.inject({}){ |h, (k, v)| h[k.to_sym] = v.is_a?(::Hash) ? v.deep_symbolize_keys : v; h }
        end

        def deep_symbolize_keys!
          replace(deep_symbolize_keys)
        end
      end
    end
  end
end
