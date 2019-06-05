require_relative "url"

module Types
  class MemoType < GraphQL::Schema::Object
    description "A memo"
    field :id, ID, null: false
    field :title, String, null: false
    field :description, String, null: true
    field :url, Types::Url, null: true
  end
end
