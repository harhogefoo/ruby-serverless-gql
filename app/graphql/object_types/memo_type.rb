# frozen_string_literal: true

require_relative 'base_object'
require_relative '../scalar_types/url_type'

module ObjectTypes
  class MemoType < BaseObject
    description 'A memo'
    field :id, ID, null: true
    field :title, String, null: true
    field :name, String, null: true
    field :description, String, null: true
    field :url, ScalarTypes::UrlType, null: true
    field :errors, [String], null: true
  end
end
