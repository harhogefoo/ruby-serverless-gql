require_relative "post_type"
require_relative "../../models/post"
require_relative "memo_type"
require_relative "../../models/memo"

module Types
  class QueryType < GraphQL::Schema::Object
    description "The query root of this schema"

    # First describe the field signature:
    field :post, PostType, null: true do
      description "Find a post by ID"
      argument :id, ID, required: true
    end

    # Then provide an implementation:
    def post(id:)
      Post.find(id)
    end

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
