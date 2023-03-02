module Types
  class MutationType < Types::BaseObject
    field :create_task_list, mutation: Mutations::CreateTaskList
    field :delete_task_list, mutation: Mutations::DeleteTaskList
  end
end
