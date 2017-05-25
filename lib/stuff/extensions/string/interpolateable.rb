module Stuff
  module Extensions
    module String
      module Interpolateable
        INTERPOLATION_REGEX = /%{(\w+)}/.freeze

        def interpolateable?
          INTERPOLATION_REGEX.match?(self)
        end

        # Converts interpolateable strings only to Regexp
        #
        # @example
        #   "foo %{bar}".interpolateable_to_regexp
        #   # => /foo (?<bar>.+)/
        #
        #   'foo bar'.interpolateable_to_regexp
        #   # => nil
        #
        def interpolateable_to_regexp
          return nil unless interpolateable?

          Regexp.compile(self.scan(INTERPOLATION_REGEX).inject(Regexp.quote(self).to_s){ |s, sr| s.sub("%\\{#{ sr[0] }\\}", "(?<#{ sr[0] }>.+)") })
        end
      end
    end
  end
end
