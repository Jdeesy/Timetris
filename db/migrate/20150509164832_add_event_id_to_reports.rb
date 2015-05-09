class AddEventIdToReports < ActiveRecord::Migration
  def change
    add_column :task_reports, :event_id, :string
  end
end
