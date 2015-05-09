class TaskReportsController < ApplicationController
  def index
    @taskreports = current_user.task_reports.select{ |report| report.end_time }
  end
end
