# frozen_string_literal: true

require 'uri'

require_relative 'base_scalar'

module ScalarTypes
  class UrlType < BaseScalar
    description 'A valid URL, transported as a string'

    def self.coerce_input(input_value, _context)
      # Parse the incoming object into a `URI`
      url = URI.parse(input_value)
      # It's valid, return the URI object
      return url if url.is_a?(URI::HTTP) || url.is_a?(URI::HTTPS)

      raise GraphQL::CoercionError, "#{input_value.inspect} is not a valid URL"
    end

    def self.coerce_result(ruby_value, _context)
      # It's transported as a string, so stringify it
      ruby_value.to_s
    end
  end
end
