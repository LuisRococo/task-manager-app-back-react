# frozen_string_literal: true

module Types
  class TaskType < Types::BaseObject
    field :id, Integer, null: false
    field :title, String
    field :order, Integer
    field :creator_id, Integer
    field :started_at, GraphQL::Types::ISO8601DateTime
    field :finished_at, GraphQL::Types::ISO8601DateTime
    field :doing_time, Integer
    field :justification, String
    field :task_list_id, Integer
    field :creator_name, String
    field :assigned_quantity, Integer
    field :description, String
    field :task_list, Types::TaskListType
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :completed, Boolean
    field :points, Integer
  end
end
