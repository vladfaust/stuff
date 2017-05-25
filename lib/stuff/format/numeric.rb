module Stuff
  module Format
    module Numeric
      def self.to_percentage(value,
        significant: 0,
        percentage_sign: true,
        decimal_sign: '.',
        strip_significant_when_no_decimals: true
      )
        significant = 0 if strip_significant_when_no_decimals && value.to_f * 100 % 1 == 0

        result = (value.to_f * 100).round(significant).to_s
        result.sub!('.', decimal_sign) unless decimal_sign == '.'
        result += '%' if percentage_sign

        result
      end
    end
  end
end
