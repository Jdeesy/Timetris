class TaskReportsController < ApplicationController
  def index
    @taskreports = current_user.task_reports.select{ |report| report.end_time }.includes(:task)
  end

  def patch
    taskreport = TaskReport.find_by(id: params[:id])
    taskreport.update(start_time: Time.now.utc)
    redirect_to taskreport
  end

  def show
  end
end
