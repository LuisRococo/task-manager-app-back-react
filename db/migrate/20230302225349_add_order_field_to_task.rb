class AddOrderFieldToTask < ActiveRecord::Migration[6.1]
  def change
    add_column :tasks, :order, :integer, default: 0
  end
end
