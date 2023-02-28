# frozen_string_literal: true

module Types
  class TaskChangeRecordType < Types::BaseObject
    field :id, ID, null: false
    field :task_id, Integer
    field :new_list, String
    field :date, GraphQL::Types::ISO8601DateTime
  end
end
