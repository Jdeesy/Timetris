class Task < ActiveRecord::Base
  belongs_to :creator, class_name: "User"

  def target_finish_time
    Time.at(self.start_time).utc + (self.time_box * 60)
  end

  def task_time
    return ((end_time - start_time)/60).to_i
  end

  def difference
    time_box - task_time
  end

  def time_box_difference
    if difference >= 0
      return "#{difference} minutes under"
    else
      return "#{0-difference} minutes over"
    end
  end

  def task_in_progress
    self.start_time && self.end_time == nil
  end
end
