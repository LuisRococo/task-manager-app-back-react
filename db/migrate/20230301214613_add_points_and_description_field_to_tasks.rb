class AddPointsAndDescriptionFieldToTasks < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :points, :integer, default: 0
    add_column :tasks, :description, :text, default: ''
  end
end
