class TasksController < ApplicationController
  def index
    @task = Task.new
    @tasks = current_user.pending_tasks
  end

  def create
    task = Task.new(task_params)
    task.update(creator: current_user)
    TaskReport.create(task: task)
    redirect_to tasks_path
  end

  def show
    @task = Task.find_by(id: params[:id])
  end

  private

    def task_params
      params.require(:task).permit(:name)
    end
end
