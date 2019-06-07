# frozen_string_literal: true

require_relative 'base_mutation'
require_relative '../scalar_types/url_type'
require_relative '../object_types/memo_type'
require_relative '../input_types/memo_input_type'
require_relative '../../models/memo'

module Mutations
  class UpdateMemo < Mutations::BaseMutation
    argument :memo, InputTypes::MemoInputType, required: true

    field :id, ID, null: true
    field :title, String, null: true
    field :name, String, null: true
    field :description, String, null: true
    field :url, ScalarTypes::UrlType, null: true
    field :errors, [String], null: true

    def resolve(memo:)
      input_memo = memo.to_h
      user_id = context[:user_id]
      unless user_id
        return {
          errors: ['user_id was not set']
        }
      end
      current_memo = Memo.find(id: input_memo[:id], user_id: user_id)
      unless current_memo
        return {
          errors: ['memo not found']
        }
      end
      input_memo.delete(:id)
      if current_memo.update(input_memo)
        current_memo.to_h
      else
        {
          errors: current_memo.errors
        }
      end
    end
  end
end
