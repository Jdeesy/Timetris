class TasksController < ApplicationController

  skip_before_action :require_completed_task, only: [:show, :complete]

  def create
    task = Task.new(task_params)
    task.update(creator: current_user)
    redirect_to pending_path
  end

  def show
    @task = Task.find_by(id: params[:id])
    render layout: "layouts/in_progress" if @task.task_in_progress
  end

  def start
    task = Task.find_by(id: params[:id])
    calendar_event = current_user.begin_task(task)
    task.update(event_id: calendar_event.id, start_time: Time.at(calendar_event.start['dateTime']))
    redirect_to task
  end

  def complete
    task = Task.find_by(id: params[:id])
    calendar_event = current_user.complete_task(task)
    task.update(event_id: calendar_event.id, end_time: Time.at(calendar_event.end['dateTime']))
    redirect_to task
  end

  def destroy
    @task = Task.find_by(id: params[:id])
    @task.destroy
    redirect_to pending_path
  end

  private

  def task_params
    params.require(:task).permit(:name)
  end

end
