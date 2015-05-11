class AddDefaultToSnoozeUntil < ActiveRecord::Migration
  def change
    change_column_default(:users, :snooze_until, Time.new(1776, 07, 04, 0, 0, 0))
  end
end
