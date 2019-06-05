require_relative "base_object"
require_relative "../scalar_types/url_type"

module ObjectTypes
  class MemoType < BaseObject
    description "A memo"
    field :id, ID, null: false
    field :title, String, null: false
    field :name, String, null: true
    field :description, String, null: true
    field :url, ScalarTypes::UrlType, null: true
  end
end
