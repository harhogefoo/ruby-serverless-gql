require_relative "memo_type"
require_relative "../../models/memo"

module Types
  class QueryType < GraphQL::Schema::Object
    description "The query root of this schema"

    field :memos, [MemoType], null: true do
      description "Find all memo"
    end

    def memos()
      Memo.all
    end

    field :memo, MemoType, null: true do
      description "Find a memo by ID"
      argument :id, ID, required: true
    end

    def memo(id:)
      Memo.find(id)
    end

  end
end
