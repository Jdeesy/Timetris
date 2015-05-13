class Task < ActiveRecord::Base
  belongs_to :creator, class_name: "User"
  validates :time_box, :inclusion => { in: 1..1440 }
  validates :priority, :inclusion => { in: 1..3 }
  validates :name, length: { in: 4..140 }
  validate :due_date_validation

  def due_date_validation
    errors.add(:due_date, "can't be in the past") if
      !due_date.blank? and due_date < Date.today
  end

  def target_finish_time
    Time.at(self.start_time).utc + (self.time_box * 60)
  end

  def duration
    if start_time && end_time
      return ((end_time - start_time)/60).to_i
    else
      return 0
    end
  end

  def time_box_difference
    time_box - duration
  end

  def time_box_difference_in_words
    if time_box_difference >= 0
      return "#{time_box_difference} min under"
    else
      return "#{0 - time_box_difference} min over"
    end
  end

  def task_in_progress
    self.start_time && !self.end_time
  end

  def time_box_subtract
    self.time_box -= self.creator.default_time_increment
  end

  def time_box_add
    self.time_box += self.creator.default_time_increment
  end

  def priority_subtract
    self.priority += 1
  end

  def priority_add
    self.priority -= 1
  end

  def calendar_event_created?
    self.task_in_progress || self.end_time
  end
end
