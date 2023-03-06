module Mutations
    class PatchTask < BaseMutation
      # arguments passed to the `resolve` method
      argument :id, Integer, required: true
      argument :title, String, required: false
      argument :description, String, required: false
      argument :points, Integer, required: false
      argument :taskListId, Integer, required: false
      argument :order, Integer, required: false
      argument :completed, Boolean, required: false
  
      # return type from the mutation
      type Types::TaskType
  
      def resolve(id:, title:, description:, points:, taskListId:, order:, completed:)
        if taskListId
          target_list = TaskList.find(taskListId)
          if target_list
            if target_list.tasks.count > 0
              order = target_list.tasks.order(order: :ASC).last.order + 1
            else
              order = 1
            end
          end
        end

        task_to_update = Task.find(id)
        task_to_update.title = title if title
        task_to_update.description = description if description
        task_to_update.points = points if points
        task_to_update.task_list_id = taskListId if taskListId
        task_to_update.order = order if order
        task_to_update.completed = completed if completed
        task_to_update.save!
        task_to_update
      end
    end
  end
