module Mutations
    class PatchBoard < BaseMutation
      # arguments passed to the `resolve` method
      argument :id, Integer, required: true
      argument :title, String, required: false
      argument :isPublic, Boolean, required: false
  
      # return type from the mutation
      type Types::BoardType
  
      def resolve(id:, title:, isPublic:)
        board_to_edit = Board.find(id)
        board_to_edit.title = title if title
        board_to_edit.is_public = isPublic unless isPublic.nil?
        board_to_edit.save!
        board_to_edit
      end
    end
  end
