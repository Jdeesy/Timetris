class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :require_login, :require_completed_task
  helper_method :current_user, :format_local_time, :last_half_hour


  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def format_local_time(time)
    return Time.at(time).in_time_zone.strftime("%A, %b %e at %l:%M %p")
  end

  def last_half_hour
    hour = Time.now.hour % 12
    minutes = Time.now.min / 30
    if minutes == 0
      return ["#{hour}:00", "#{hour}:30", "#{hour + 1}:00", "#{hour + 1}:30",
               "#{hour + 2}:00", "#{hour + 2}:30", "#{hour + 3}:00", "#{hour + 3}:30",
               "#{hour + 4}:00", "#{hour + 4}:30", "#{hour + 5}:00", "#{hour + 5}:30"]
    else
      return ["#{hour}:30", "#{hour + 1}:00", "#{hour + 1}:30", "#{hour + 2}:00",
               "#{hour + 2}:30", "#{hour + 3}:00", "#{hour + 3}:30", "#{hour + 4}:00",
               "#{hour + 4}:30", "#{hour + 5}:00", "#{hour + 5}:30", "#{hour + 6}:00"]
    end
  end

  private

  def require_login
    redirect_to welcome_path unless current_user
  end

  def require_completed_task
    if current_user && current_user.tasks.any?
      task = current_user.tasks.last
      redirect_to task if task.task_in_progress
    end
  end

end
