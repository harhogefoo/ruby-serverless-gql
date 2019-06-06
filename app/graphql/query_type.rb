require_relative "./object_types/memo_type"
require_relative "../models/memo"

class QueryType < GraphQL::Schema::Object
  description "The query root of this schema"

  field :memos, [ObjectTypes::MemoType], null: true do
    description "Find all memo"
  end

  def memos
    # TODO: user_idを取得する箇所は他でも行っているので切り出す
    user_id = context[:user_id]

    unless user_id
      return {
        errors: ['user_id was not set']
      }
    end

    params = {
      table_name: 'memo',
      expression_attribute_names: {'#user_id' => 'user_id'},
      expression_attribute_values: {':user_id' => user_id},
      key_condition_expression: '#user_id = :user_id',
      index_name: 'userIdGSI',
    }
    result = Memo.query(params)
    result.map{ |memo| memo.to_h }
  end

  field :memo, ObjectTypes::MemoType, null: true do
    description "Find a memo by id"
    argument :id, ID, required: true
  end

  def memo(id:)
    user_id = context[:user_id]
    unless user_id
      return {
        errors: ['user_id was not set']
      }
    end
    result = Memo.find(id: id, user_id: user_id)
    result.to_h
  end
end
