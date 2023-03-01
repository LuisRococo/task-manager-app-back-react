module Types
  class QueryType < Types::BaseObject
    field :users, [Types::UserType], null: false
    def users
      User.all
    end

    field :boards, [Types::BoardType], null: false
    def boards
      Board.all
    end

    field :board, Types::BoardType, null: false do
      argument :id, ID, required: true
    end
    def board(id:)
      Board.find(id)
    end
  end
end
