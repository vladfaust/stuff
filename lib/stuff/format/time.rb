module Stuff
  module Format
    module Time
      def self.to_ms(time)
        "#{ (time * 1000.0).floor }ms"
      end
    end
  end
end
