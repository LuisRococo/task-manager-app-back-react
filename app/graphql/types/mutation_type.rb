module Types
  class MutationType < Types::BaseObject
    field :create_task_list, mutation: Mutations::CreateTaskList
  end
end
