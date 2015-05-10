class HomeController < ApplicationController
  skip_before_action :require_login, only: [:welcome]

  def index
    @time_to_next_event = current_user.time_to_next_event
    @upcoming_events = current_user.upcoming_events
    @next_event = @upcoming_events[0]
    @tasks = current_user.possible_tasks
  end

  def pending
    @task = Task.new
    @tasks = current_user.pending_tasks
  end

  def completed
    @tasks = current_user.completed_tasks
  end

  def reports
    @tasks = current_user.completed_tasks
  end

  def welcome
  end
end
