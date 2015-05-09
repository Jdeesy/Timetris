class HomeController < ApplicationController
  skip_before_action :require_login, only: [:welcome]

  def index
    @user = current_user
    @time_to_next_event = @user.time_to_next_event
    @upcoming_events = @user.upcoming_events
    @next_event = @upcoming_events[0]
    @tasks = @user.possible_tasks
  end

  def completed
    @tasks = current_user.task_reports.select{ |report| report.end_time }
  end

  def welcome

  end
end
