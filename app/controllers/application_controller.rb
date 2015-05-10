class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  helper_method :current_user

  before_action :require_login, :require_completed_task

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

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
