class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.integer  :creator_id, null: false
      t.string   :name, null: false
      t.integer  :time_box, null: false, default: 15
      t.datetime :due_date
      t.datetime :start_time
      t.datetime :end_time
      t.string   :event_id

      t.timestamps null: false
    end
  end
end
