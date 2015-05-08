class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer :user_id
      t.integer :time_box
      t.datetime :due_date

      t.timestamps null: false
    end
  end
end
