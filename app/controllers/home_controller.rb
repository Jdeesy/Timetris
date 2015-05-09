class HomeController < ApplicationController
  def index
    @user = current_user
    @time_to_next_event = @user.time_to_next_event
    @upcoming_events = @user.upcoming_events
    @next_event = @upcoming_events[0]
    @possible_tasks = @user.task_reports.includes(:task).select do |report|
      report.task.time_box <= @time_to_next_event
    end
  end

  def completed
    @tasks = current_user.task_reports.select{ |report| report.end_time }
  end

  def welcome

  end
end
