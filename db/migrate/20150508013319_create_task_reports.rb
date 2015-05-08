class CreateTaskReports < ActiveRecord::Migration
  def change
    create_table :task_reports do |t|
      t.integer :task_id
      t.datetime :start_time
      t.datetime :end_time

      t.timestamps null: false
    end
  end
end
