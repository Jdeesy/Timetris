class AddLastAlertTimestamp < ActiveRecord::Migration
  def change
    add_column :users, :last_alert, :datetime, default: Time.new(1776, 07, 04, 0, 0, 0)
  end
end
