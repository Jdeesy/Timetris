class AddDefaultTimeIncrementToUsers < ActiveRecord::Migration
  def change
    add_column :users, :default_time_increment, :integer, default: 15
  end
end
