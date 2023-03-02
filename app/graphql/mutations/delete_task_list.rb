module Mutations
    class DeleteTaskList < BaseMutation
      # arguments passed to the `resolve` method
      argument :id, Integer, required: true
  
      # return type from the mutation
      type Types::TaskListType
  
      def resolve(id:)
        task_list_to_delete = TaskList.find(id)
        task_list_to_delete.destroy
        task_list_to_delete
      end
    end
  end
