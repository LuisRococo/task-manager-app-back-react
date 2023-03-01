# frozen_string_literal: true

module Types
  class TaskListType < Types::BaseObject
    field :id, ID, null: false
    field :name, String
    field :color, String
    field :priority, Integer
    field :board_id, Integer
    field :tasks, [Types::TaskType]
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
