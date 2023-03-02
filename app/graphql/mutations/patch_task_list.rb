module Mutations
    class PatchTaskList < BaseMutation
      # arguments passed to the `resolve` method
      argument :id, Integer, required: true
      argument :name, String, required: false
      argument :priority, Integer, required: false
      argument :color, String, required: false
  
      # return type from the mutation
      type Types::TaskListType
  
      def resolve(id:, name:, priority:, color:)
        task_list_to_update = TaskList.find(id)
        task_list_to_update.name = name if name
        task_list_to_update.priority = priority if priority
        task_list_to_update.color = color if color
        task_list_to_update.save!
        task_list_to_update
      end
    end
  end
