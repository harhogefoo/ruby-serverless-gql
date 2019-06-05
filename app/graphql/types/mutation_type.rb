require_relative "base_object"
require_relative "../mutations/create_memo"

module Types
  class MutationType < Types::BaseObject
    field :create_memo, mutation: Mutations::CreateMemo
  end
end
