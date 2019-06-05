require_relative "base_input_object"
require_relative "url"

module Types
  class MemoInputType < BaseInputObject
    description "Memo input type"

    argument :title, String, required: true
    argument :description, String, required: false
    argument :url, Types::Url, required: false
  end
end
