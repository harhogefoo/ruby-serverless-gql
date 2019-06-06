require_relative "base_mutation"
require_relative "../scalar_types/url_type"
require_relative "../object_types/memo_type"
require_relative "../input_types/memo_input_type"
require_relative "../../models/memo"

module Mutations
  class UpdateMemo < Mutations::BaseMutation
    argument :memo, InputTypes::MemoInputType, required: true

    field :id, ID, null: true
    field :title, String, null: true
    field :name, String, null: true
    field :description, String, null: true
    field :url, ScalarTypes::UrlType, null: true
    field :errors, [String], null: false

    def resolve(memo:)
      inputMemo = memo.to_h
      user_id = context[:user_id]
      unless user_id
        return {
          errors: ['user_id was not set']
        }
      end
      currentMemo = Memo.find(id: inputMemo[:id], user_id: user_id)
      unless currentMemo
        return {
          errors: ["memo not found"]
        }
      end
      inputMemo.delete(:id)
      if currentMemo.update(inputMemo) then
        currentMemo.to_h
      else
        {
          errors: currentMemo.errors
        }
      end
    end
  end
end
