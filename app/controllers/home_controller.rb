class HomeController < ApplicationController
  skip_before_action :require_login, only: [:welcome]

  def index
    @task = current_user.current_task
    @upcoming_events = current_user.upcoming_events
    @time_to_next_event = current_user.time_to_next_event(@upcoming_events)
    @next_event = @upcoming_events.first
    @tasks = current_user.possible_tasks(@upcoming_events)
  end

  def completed
    @tasks = current_user.completed_tasks.sort_by{ |task| task.end_time }.reverse
  end

  def past
    @tasks = current_user.completed_tasks.sort_by{ |task| task.end_time }.reverse

    @count = current_user.total_count
    @time_box = current_user.total_time_box
    @task_time = current_user.total_task_time
    @avg_difference = current_user.average_difference
  end

  def welcome
  end

  def complete_calendar
    @upcoming_events = current_user.upcoming_events
    @next_event = @upcoming_events[0]
    current_user.complete_calendar_event(@next_event)
    redirect_to root_path
  end

  def future
    @upcoming_events = current_user.upcoming_events
    google_events = []
    @upcoming_events.each{ |event| google_events << [event, event.start["dateTime"].to_i]}

    predicted_events = current_user.predict_tasks(current_user.find_the_gaps(current_user.sort_upcoming_events(@upcoming_events)))

    @events = google_events + predicted_events
    @events.sort_by!{ |e| e[1] }
  end

  def alert
    if request.xhr?
      upcoming_events = current_user.upcoming_events
      task = current_user.possible_tasks(upcoming_events).first
      render json: @tasks.first
    end
  end
end
