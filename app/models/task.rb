class Task < ActiveRecord::Base
  belongs_to :creator, class_name: "User"
  validates :time_box, :inclusion => { in: 1..1440 }
  validates :priority, :inclusion => { in: 1..3 }

  def target_finish_time
    Time.at(self.start_time).utc + (self.time_box * 60)
  end

  def task_time
    if start_time && end_time
      return ((end_time - start_time)/60).to_i
    else
      return 0
    end
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
    self.start_time && !self.end_time
  end

  def time_box_subtract
    self.update(time_box: self.time_box -= self.creator.default_time_increment)
  end

  def time_box_add
    self.update(time_box: self.time_box += self.creator.default_time_increment)
  end

  def priority_subtract
    self.update(priority: self.priority -= 1)
  end

  def priority_add
    self.update(priority: self.priority += 1)
  end

  def calendar_event_created?
    self.task_in_progress || self.end_time
  end
end
