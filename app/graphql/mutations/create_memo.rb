require_relative "base_mutation"
require_relative "../scalar_types/url_type"
require_relative "../object_types/memo_type"
require_relative "../input_types/memo_input_type"

module Mutations
  class CreateMemo < Mutations::BaseMutation
    argument :memo, InputTypes::MemoInputType, required: true

    field :title, String, null: true
    field :description, String, null: true
    field :url, ScalarTypes::UrlType, null: true
    field :errors, [String], null: false

    def resolve(memo:)
      # TODO: DynamoDBに接続して保存処理を行う
      if true then
        {
          title: memo[:title],
          description: memo[:description],
          url: memo[:url],
          errors: nil
        }
      else
        # TODO: 保存に失敗した場合エラーを返す
        {
          errors: nil
        }
      end
    end
  end
end
