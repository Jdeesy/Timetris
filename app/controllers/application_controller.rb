class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :require_login, :require_completed_task
  helper_method :current_user, :format_local_time, :format_report_time, :format_priority


  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def format_local_time(time)
    return Time.at(time).in_time_zone.strftime("%A, %b %e at %l:%M %p")
  end

  def format_report_time(time)
    return Time.at(time).in_time_zone.strftime("%m/%d/%y")
  end

  def format_priority(task)
    return "High" if task.priority == 1
    return "Medium" if task.priority == 2
    return "Low" if task.priority == 3
  end

  # def build_calendar(events)
  #   calendar = Array.new(12).map.with_index do |r, i|
  #     time = Time.new(Time.now.year, Time.now.month, Time.now.day, Time.now.hour, (Time.now.min / 30) * 30) + (i * 1800)
  #     time_slot = [time.strftime("%I:%M %p")]
  #     events.each do |event|
  #       time_slot.push(event.summary) if (event.start.dateTime >= time && event.start.dateTime < time + 1800) || (event.end.dateTime > time && event.end.dateTime <= time + 1800)
  #     end
  #     time_slot
  #   end

  #   return calendar
  # end

  private

  def require_login
    redirect_to welcome_path unless current_user
  end

  def require_completed_task
    if current_user
      tasks = current_user.pending_tasks
      if tasks.any?
        tasks.each do |task|
          redirect_to task if task.task_in_progress
        end
      end
    end
  end

end
