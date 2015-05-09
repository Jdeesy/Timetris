class Task < ActiveRecord::Base
  belongs_to :creator, class_name: "User"

  def target_finish_time
    Time.at(self.start_time).utc + (self.time_box * 60)
  end
end
