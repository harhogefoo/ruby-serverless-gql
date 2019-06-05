require_relative "base_object"
require_relative "../mutations/create_comment"

module Types
  class MutationType < Types::BaseObject
    field :create_comment, mutation: Mutations::CreateComment
  end
end
