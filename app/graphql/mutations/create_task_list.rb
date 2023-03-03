module Mutations
    class CreateTaskList < BaseMutation
      # arguments passed to the `resolve` method
      argument :name, String, required: true
      argument :color, String, required: true
      argument :priority, Integer, required: true
      argument :board_id, Integer, required: true
  
      # return type from the mutation
      type Types::TaskListType
  
      def resolve(name:, color:, priority:, board_id:)
        new_list = TaskList.new(
          name: name,
          color: color,
          priority: priority,
          board_id: board_id
        )
        new_list.save!
        new_list
      end
    end
  end
