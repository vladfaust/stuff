module Stuff
  module Extensions
    module Object
      module As
        # Just as Object.tap, but returns the value instead of the object. It's like each and map for an Array
        #
        # @example
        #   'kek'.as{ |s| s.upcase }
        #   # => 'KEK'
        #
        def as
          yield self
        end
      end
    end
  end
end
