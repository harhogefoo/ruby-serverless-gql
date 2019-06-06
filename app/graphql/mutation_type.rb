# frozen_string_literal: true

require_relative './mutations/create_memo'
require_relative './mutations/update_memo'

class MutationType < GraphQL::Schema::Object
  field :create_memo, mutation: Mutations::CreateMemo
  field :update_memo, mutation: Mutations::UpdateMemo
end
