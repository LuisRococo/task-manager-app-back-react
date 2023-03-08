module Mutations
    class PatchUser < BaseMutation
      # arguments passed to the `resolve` method
      argument :id, Integer, required: true
      argument :firstName, String, required: false
      argument :lastName, String, required: false
  
      # return type from the mutation
      type Types::UserType
  
      def resolve(id:, firstName:, lastName:)
        user_to_edit = User.find(id)
        user_to_edit.first_name = firstName if firstName
        user_to_edit.last_name = lastName if lastName
        user_to_edit.save!
        user_to_edit
      end
    end
  end
