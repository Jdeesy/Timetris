class HomeController < ApplicationController
  def index

  end

  def completed
    @tasks = current_user.task_reports.select{ |report| report.end_time }
  end
end
