require_relative "base_mutation"
require_relative "../scalar_types/url_type"
require_relative "../object_types/memo_type"
require_relative "../input_types/memo_input_type"
require_relative "../../models/memo"

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
      newMemo = Memo.new(
        id: SecureRandom.uuid,
        user_id: "user",
        title: memo[:title],
        name: memo[:name],
        description: memo[:description],
        url: memo[:url]
      )
      if newMemo.save then
        m = newMemo.to_h
        {
          id: m[:id],
          title: m[:title],
          name: m[:name],
          description: m[:description],
          url: m[:url],
          errors: nil
        }
      else
        {
          errors: newMemo.errors
        }
      end
    end
  end
end
