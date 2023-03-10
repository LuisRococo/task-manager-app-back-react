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
        
        new_order_position = 1
        if (task_list.tasks.count > 0)
          new_order_position = task_list.tasks.order(order: :ASC).last.order + 1
        end
        
        new_task = Task.new(title: title, points: points, 
                    description: description, task_list_id: taskListId,
                    creator_id: board_manager.id, completed: false, 
                    order: new_order_position)
        new_task.save!
        new_task
      end
    end
  end
