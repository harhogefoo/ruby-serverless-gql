# frozen_string_literal: true

require_relative 'base_mutation'
require_relative '../scalar_types/url_type'
require_relative '../object_types/memo_type'
require_relative '../input_types/memo_input_type'
require_relative '../../models/memo'

module Mutations
  class CreateMemo < Mutations::BaseMutation
    argument :memo, InputTypes::MemoInputType, required: true

    field :id, ID, null: true
    field :title, String, null: true
    field :name, String, null: true
    field :description, String, null: true
    field :url, ScalarTypes::UrlType, null: true
    field :errors, [String], null: false

    def resolve(memo:)
      user_id = context[:user_id]
      unless user_id
        return {
          errors: ['user_id was not set']
        }
      end
      new_memo = Memo.new(
        id: SecureRandom.uuid,
        user_id: user_id,
        title: memo[:title],
        name: memo[:name],
        description: memo[:description],
        url: memo[:url]
      )
      if new_memo.save
        new_memo.to_h
      else
        {
          errors: new_memo.errors
        }
      end
    end
  end
end
