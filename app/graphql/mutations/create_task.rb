module Mutations
    class CreateTask < BaseMutation
      # arguments passed to the `resolve` method
      argument :title, String, required: true
      argument :points, Integer, required: true
      argument :description, String, required: true
      argument :taskListId, Integer, required: true
  
      # return type from the mutation
      type Types::TaskType
  
      def resolve(title:, points:, description:, taskListId:)
        # TODO: Change board manager to current user
        task_list = TaskList.find(taskListId)
        board_manager = task_list.board.author
        new_order_position = task_list.tasks.count + 1
        Task.create!(title: title, points: points, 
                    description: description, task_list_id: taskListId,
                    creator_id: board_manager.id, completed: false, 
                    order: new_order_position)
      end
    end
  end
