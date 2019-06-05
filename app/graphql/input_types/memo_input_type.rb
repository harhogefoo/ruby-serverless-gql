require_relative "base_input_object"
require_relative "../scalar_types/url_type"

module InputTypes
  class MemoInputType < BaseInputObject
    description "Memo input type"

    argument :title, String, required: true
    argument :description, String, required: false
    argument :url, ScalarTypes::UrlType, required: false
  end
end
