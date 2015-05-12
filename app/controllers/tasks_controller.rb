class TasksController < ApplicationController

  skip_before_action :require_completed_task, only: [:show, :complete, :update]

  def create
    task = Task.new(task_params)
    task.update(creator: current_user)
    redirect_to pending_path
  end

  def show
    @browser_timezone = browser_timezone
    if @task = Task.find_by(id: params[:id])
      if request.xhr?
        render json: @task
      # render layout: "layouts/in_progress" if @task.task_in_progress
      end
    else
      redirect_to root_path
    end
  end

  def start
    task = Task.find_by(id: params[:id])
    if request.xhr?
      render partial: "tasks/alert", locals: {task: task}
    else
      calendar_event = current_user.begin_task(task)
      task.update(event_id: calendar_event.id, start_time: Time.at(calendar_event.start['dateTime']))
      redirect_to task
    end
  end

  def complete
    task = Task.find_by(id: params[:id])
    calendar_event = current_user.complete_task(task)
    task.update(event_id: calendar_event.id, end_time: Time.at(calendar_event.end['dateTime']))
    redirect_to task
  end

  def edit
    @task = Task.find_by(id: params[:id])
    if request.xhr?
      render partial: "new"
    else
      redirect_to pending_path
    end
  end

  def destroy
    @task = Task.find_by(id: params[:id])
    @task.destroy
    redirect_to pending_path
  end

  def update
    @task = Task.find_by(id: params[:id])
    @task.update(task_params)
    if @task.calendar_event_created?
      calendar_event = current_user.update_event_description(@task)
      calendar_event.description = @task.description
    end
    if request.xhr?
      render partial: "list_item_header", locals: {task: @task}
    else
      redirect_to pending_path
    end
  end

  def time_box_subtract
    if request.xhr?
      @task = Task.find_by(id: params[:id])
      @task.time_box_subtract
      render json: Task.find_by(id: params[:id])
    end
  end

  def time_box_add
    if request.xhr?
      @task = Task.find_by(id: params[:id])
      @task.time_box_add
      render json: Task.find_by(id: params[:id])
    end
  end

  def priority_subtract
    if request.xhr?
      @task = Task.find_by(id: params[:id])
      @task.priority_subtract
      render json: Task.find_by(id: params[:id])
    end
  end

  def priority_add
    if request.xhr?
      @task = Task.find_by(id: params[:id])
      @task.priority_add
      render json: Task.find_by(id: params[:id])
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :due_date, :description)
  end

end
