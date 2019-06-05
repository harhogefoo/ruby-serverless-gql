require_relative "./mutations/create_memo"

class MutationType < GraphQL::Schema::Object
  field :create_memo, mutation: Mutations::CreateMemo
end
