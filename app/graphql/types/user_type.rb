# frozen_string_literal: true

module Types
  class UserType < Types::BaseObject
    field :id, ID, null: false
    field :email, String, null: false
    field :encrypted_password, String, null: false
    field :reset_password_token, String
    field :reset_password_sent_at, GraphQL::Types::ISO8601DateTime
    field :remember_created_at, GraphQL::Types::ISO8601DateTime
    field :created_at, GraphQL::Types::ISO8601DateTime, null: false
    field :updated_at, GraphQL::Types::ISO8601DateTime, null: false
    field :confirmation_token, String
    field :confirmed_at, GraphQL::Types::ISO8601DateTime
    field :confirmation_sent_at, GraphQL::Types::ISO8601DateTime
    field :unconfirmed_email, String
    field :authorization_tier, String
    field :first_name, String
    field :last_name, String
    field :manager_id, Integer
    field :invitation_token, String
    field :invitation_created_at, GraphQL::Types::ISO8601DateTime
    field :invitation_sent_at, GraphQL::Types::ISO8601DateTime
    field :invitation_accepted_at, GraphQL::Types::ISO8601DateTime
    field :invitation_limit, Integer
    field :invited_by_type, String
    field :invited_by_id, Integer
    field :invitations_count, Integer
    field :trial_block, Boolean
    field :paid_date, GraphQL::Types::ISO8601DateTime
    field :plan_id, Integer
    field :pay_block, Boolean
    field :stripe_user_id, String
    field :user_block, Boolean
    field :white_listed, Boolean
    field :board_update_notification, Boolean
    field :board_delete_notification, Boolean
    field :board_create_notification, Boolean
  end
end
