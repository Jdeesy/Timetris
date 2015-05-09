class AddDefaultToTasks < ActiveRecord::Migration
  def change
    change_column_default :tasks, :time_box, 15
  end
end
