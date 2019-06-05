require_relative "base_mutation"

module Mutations
  class CreateComment < Mutations::BaseMutation
    argument :user_id, Int, required: true
    argument :post_id, Int, required: true
    argument :body, String, required: true

    field :comment, String, null: true
    field :errors, [String], null: false

    def resolve(user_id:, post_id:, body:)
      # TODO: DynamoDBに接続して保存処理を行う
      {
        comment: nil,
        errors: nil
      }
    end
  end
end
