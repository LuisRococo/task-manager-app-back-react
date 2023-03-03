module Mutations
    class DeleteTask < BaseMutation
      # arguments passed to the `resolve` method
      argument :id, Integer, required: true
  
      # return type from the mutation
      type Types::TaskType
  
      def resolve(id:)
        task_to_delete = Task.find(id)
        task_to_delete.destroy
        task_to_delete
      end
    end
  end
