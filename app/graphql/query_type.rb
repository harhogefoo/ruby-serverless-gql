require_relative "./object_types/memo_type"
require_relative "../models/memo"

class QueryType < GraphQL::Schema::Object
  description "The query root of this schema"

  field :memos, [ObjectTypes::MemoType], null: true do
    description "Find all memo"
  end

  def memos()
    Memo.all
  end

  field :memo, ObjectTypes::MemoType, null: true do
    description "Find a memo by ID"
    argument :id, ID, required: true
  end

  def memo(id:)
    Memo.find(id)
  end
end
