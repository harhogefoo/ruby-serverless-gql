require_relative 'base_scalar'

module ScalarTypes
  class LimitLengthString < BaseScalar
    def self.coerce_input(input_value, _context)
      if (100 < input_value.length) {
        raise GraphQL::CoercionError, "#{input_value.inspect} is too long"
      }
      return input_value
    end

    def self.coerce_result(ruby_value, _context)
      ruby_value
    end
  end
end
