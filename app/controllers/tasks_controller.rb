class TasksController < ApplicationController

  def index
    @task = Task.new
    @tasks = current_user.pending_tasks.sort_by(&:id).reverse
  end

  def create
    task = Task.new(task_params)
    task.update(creator: current_user)
    redirect_to tasks_path
  end

  def show
    @browser_timezone = browser_timezone
    if @task = Task.find_by(id: params[:id])
      if request.xhr?
        render json: @task
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
      if !current_user.current_task
        calendar_event = current_user.begin_task(task)
        task.update(event_id: calendar_event.id, start_time: Time.at(calendar_event.start['dateTime']))
      end
      redirect_to root_path
    end
  end

  def complete
    task = Task.find_by(id: params[:id])
    calendar_event = current_user.complete_task(task)
    task.update(event_id: calendar_event.id, end_time: Time.at(calendar_event.end['dateTime']))
    redirect_to root_path
  end

  def cancel
    task = Task.find_by(id: params[:id])
    current_user.remove_calendar_event(task)
    task.start_time = nil
    if task.save
      redirect_to root_path
    end
  end

  def edit
    @task = Task.find_by(id: params[:id])
    if request.xhr?
      render partial: "new"
    else
      redirect_to tasks_path
    end
  end

  def destroy
    task = Task.find_by(id: params[:id])
    if task.end_time
      task.destroy
      redirect_to past_path
    else
      task.destroy
      redirect_to tasks_path
    end
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
      redirect_to tasks_path
    end
  end

  def time_box_subtract
    if request.xhr?
      @task = Task.find_by(id: params[:id])
      @task.time_box_subtract
      @task.save
      render partial: "tasks/timebox_tag", locals: {task: Task.find_by(id: params[:id])}
    end
  end

  def time_box_add
    if request.xhr?
      @task = Task.find_by(id: params[:id])
      @task.time_box_add
      @task.save
      render partial: "tasks/timebox_tag", locals: {task: Task.find_by(id: params[:id])}
    end
  end

  def priority_subtract
    if request.xhr?
      @task = Task.find_by(id: params[:id])
      @task.priority_subtract
      @task.save
      render partial: "tasks/priority_tag", locals: {task: Task.find_by(id: params[:id])}
    end
  end

  def priority_add
    if request.xhr?
      @task = Task.find_by(id: params[:id])
      @task.priority_add
      @task.save
      render partial: "tasks/priority_tag", locals: {task: Task.find_by(id: params[:id])}
    end
  end

  private

  def task_params
    params.require(:task).permit(:name, :due_date, :description)
  end

end
