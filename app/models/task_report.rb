class TaskReport < ActiveRecord::Base
  belongs_to :task
  has_one :creator, through: :task

  def target_finish_time
    Time.at(self.start_time).utc + (self.task.time_box * 60)
  end
end
