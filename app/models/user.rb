class User < ActiveRecord::Base
  include CalendarAPI

  has_many :tasks, foreign_key: :creator_id

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.refresh_token = auth.credentials.refresh_token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save
    end
  end

  def refresh_token!
    data = {
      :client_id => GOOGLE_CLIENT_ID,
      :client_secret => GOOGLE_CLIENT_SECRET,
      :refresh_token => self.refresh_token,
      :grant_type => "refresh_token"
    }
    response = ActiveSupport::JSON.decode(RestClient.post "https://accounts.google.com/o/oauth2/token", data)
    if response["access_token"].present?
      self.oauth_token = response["access_token"]
      self.oauth_expires_at = Time.now.utc + response["expires_in"]
      self.save
    end
  end

  def completed_tasks
    self.tasks.select{ |task| task.end_time }
  end

  def pending_tasks
    tasks = self.tasks.reject{ |task| task.end_time }
    due_tasks = self.tasks.select{ |task| task.due_date }.sort_by{ |task| [task.due_date, task.priority] }
    no_due_task = self.tasks.reject{ |task| task.due_date }.sort_by(&:priority)
    pending = due_tasks + no_due_task
    return pending
  end

  def possible_tasks(events)
    pending_tasks.select do |task|
      task.time_box <= time_to_next_event(events)
    end
  end

  def total_count
    self.completed_tasks.count
  end

  def total_time_box
    self.completed_tasks.map(&:time_box).reduce(:+)
  end

  def total_task_time
    self.completed_tasks.map(&:duration).reduce(:+)
  end

  def total_difference
    self.completed_tasks.map(&:time_box_difference).reduce(:+)
  end

  def average_priority
    priorities = self.completed_tasks.map(&:priority)
    if total_count != 0
      return priorities.reduce(:+) / total_count
    end
  end

  def average_difference
    if total_count != 0
      return total_difference / total_count
    end
  end

  def show_alerts
    if self.snooze_until
      return Time.at(self.snooze_until).utc < Time.now.utc
    else
      return false
    end
  end

  def show_alerts=(enabled)
    if enabled == "1" ||  enabled == true
      self.snooze_until ||= Time.new(1776, 07, 04, 0, 0, 0)
    else
      self.snooze_until = nil
    end
  end


  def sort_upcoming_events(events)
    events_array = []
    events.map do |event|
      events_array << [:start, event, event.start["dateTime"].to_i]
      events_array << [:end, event, event.end["dateTime"].to_i]  
    end

    return events_array.sort_by{ |event| event[2] }
  end

  def find_the_gaps(sorted_events) 
    gaps = []
    gap = []
    counter = 0

    if sorted_events[0][2] > Time.now.to_i
      gaps << calculate_gap_time([Time.now.to_i, sorted_events[0][2]])
    end

    sorted_events.each do |event|
      case event[0]
      when :start
        counter += 1
      when :end
        counter -= 1
      end

      if counter == 0
        gap << event[2]
      elsif gap.any?
        gap << event[2]
        gaps << calculate_gap_time(gap)
        gap = []
      end
    end

    return gaps
  end

  def calculate_gap_time(array_of_gap_times)
    return [array_of_gap_times[0], (array_of_gap_times[1] - array_of_gap_times[0])]
  end

  def predict_tasks(gaps)
    all_possible_tasks = []
    tasks = self.pending_tasks

    gaps.each do |gap|
      tasks.each do |task|
        if task.time_box <= (gap[1]/60)
          all_possible_tasks << [gap[0], task]
          tasks.delete(task)
          break
        end
      end
    end

    return all_possible_tasks
  end
end
