class AddSnoozeUntilToUsers < ActiveRecord::Migration
  def change
    add_column :users, :snooze_until, :datetime
  end
end
