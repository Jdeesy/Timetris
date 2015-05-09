class TasksController < ApplicationController

  def create
    task = Task.new(task_params)
    task.update(creator: current_user)
    TaskReport.create(task: task)
    redirect_to pending_path
  end

  def show
    @task = Task.find_by(id: params[:id])
  end

  private

  def task_params
    params.require(:task).permit(:name)
  end
end
