class TaskReportsController < ApplicationController
  def index
    @taskreports = current_user.completed_tasks
  end

  def start
    taskreport = TaskReport.find_by(id: params[:id])
    calendar_event = current_user.begin_task(taskreport)
    taskreport.update(event_id: calendar_event.id, start_time: Time.at(calendar_event.start['dateTime']))
    redirect_to taskreport
  end

  def complete
    taskreport = TaskReport.find_by(id: params[:id])
    calendar_event = current_user.complete_task(taskreport)
    taskreport.update(event_id: calendar_event.id, end_time: Time.at(calendar_event.end['dateTime']))
    redirect_to taskreport
  end

  def show
    @taskreport = TaskReport.find_by(id: params[:id])
  end
end
