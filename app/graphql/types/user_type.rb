module Types
  class UserType < Types::BaseObject
    field :id, Int, null: false
    field :name, String, null: false
    field :url, Types::Url, null: false
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :posts, [Types::PostType], null: false
    field :comments, [Types::CommentType], null: false
  end
end
