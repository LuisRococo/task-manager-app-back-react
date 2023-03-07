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
      argument :id, Integer, required: true
    end
    def board(id:)
      Board.find(id)
    end

    field :board_task_lists, [Types::TaskListType], null: false do
      argument :id, Integer, required: true
    end
    def board_task_lists(id:)
      TaskList.where(board_id: id)
    end

    field :user_boards, [Types::BoardType], null: false do
      argument :id, Integer, required: true
    end
    def user_boards(id:)
      user = User.find(id)
      user.user_boards
    end
  end
end
