class HomeController < ApplicationController
  skip_before_action :require_login, only: [:welcome]

  def index
    @upcoming_events = current_user.upcoming_events
    @task = current_user.current_task
    @time_to_next_event = current_user.time_to_next_event(@upcoming_events)
    @next_event = @upcoming_events.first
    @tasks = current_user.possible_tasks(@upcoming_events)
  end

  def past
    @tasks = current_user.completed_tasks
    @time_box = current_user.total_time_box
    @task_time = current_user.total_task_time
    @avg_difference = current_user.average_difference
  end

  def welcome
  end

  def complete_calendar
    upcoming_events = current_user.upcoming_events
    current_user.complete_calendar_event(upcoming_events.first)
    redirect_to root_path
  end

  def future
    @upcoming_events = current_user.upcoming_events
    google_events = []
    @upcoming_events.each{ |event| google_events << [event, event.start.dateTime.to_i] }

    predicted_events = current_user.predict_tasks(current_user.find_the_gaps(current_user.sort_upcoming_events(@upcoming_events)))
    @events = google_events + predicted_events
    @events.sort_by!{ |e| e[1] }
  end

end
