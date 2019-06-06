# frozen_string_literal: true

require_relative 'base_input_object'
require_relative '../scalar_types/url_type'

module InputTypes
  class MemoInputType < BaseInputObject
    description 'Memo input type'

    argument :id, ID, required: false
    argument :title, String, required: false
    argument :name, String, required: false
    argument :description, String, required: false
    argument :url, ScalarTypes::UrlType, required: false
  end
end
