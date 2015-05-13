class ApplicationController < ActionController::Base

  protect_from_forgery with: :exception
  before_action :require_login
  helper_method :current_user, :format_local_time, :format_local_time_without_date, :format_report_time, :format_priority


  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def format_local_time(time)
    return Time.at(time).in_time_zone.strftime("%A, %b %e at %l:%M %p")
  end

  def format_local_time_without_date(time)
    return Time.at(time).in_time_zone.strftime("%l:%M %p")
  end  

  def format_report_time(time)
    return Time.at(time).in_time_zone.strftime("%m/%d/%y")
  end

  def format_priority(task)
    return "High" if task.priority == 1
    return "Medium" if task.priority == 2
    return "Low" if task.priority == 3
  end

  private

  def require_login
    redirect_to welcome_path unless current_user
  end

end
