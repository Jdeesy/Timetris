class HomeController < ApplicationController
  skip_before_action :require_login, only: [:welcome]

  def index
    @upcoming_events = current_user.upcoming_events
    @time_to_next_event = current_user.time_to_next_event(@upcoming_events)
    @next_event = @upcoming_events[0]
    @tasks = current_user.possible_tasks(@upcoming_events).sort_by{ |task| task.priority }
  end

  def pending
    @task = Task.new
    @tasks = current_user.pending_tasks.sort_by{ |task| task.priority }
  end

  def completed
    @tasks = current_user.completed_tasks.sort_by{ |task| task.end_time }.reverse
  end

  def reports
    @tasks = current_user.completed_tasks.sort_by{ |task| task.end_time }.reverse

    @count = current_user.total_count
    @time_box = current_user.total_time_box
    @task_time = current_user.total_task_time
    @difference = current_user.total_difference
    @avg_difference = current_user.average_difference
    @avg_priority = current_user.average_priority
  end

  def welcome
  end

  def complete_calendar
    @upcoming_events = current_user.upcoming_events
    @next_event = @upcoming_events[0]
    current_user.complete_calendar_event(@next_event)
    redirect_to root_path
  end
end
