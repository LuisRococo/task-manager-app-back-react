# frozen_string_literal: true

module Types
  class PlanType < Types::BaseObject
    field :plan_id, Integer, null: false
    field :title, String
    field :member_quantity, Integer
    field :price_cents, Integer, null: false
    field :price_currency, String, null: false
    field :time_months, Integer
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
  end
end
