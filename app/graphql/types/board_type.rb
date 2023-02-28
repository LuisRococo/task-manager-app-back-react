# frozen_string_literal: true

module Types
  class BoardType < Types::BaseObject
    field :id, ID, null: false
    field :title, String
    field :author_id, Integer
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :is_public, Boolean
  end
end
