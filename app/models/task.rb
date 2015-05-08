class Task < ActiveRecord::Base
  include CalendarAPI

  belongs_to :creator, class_name: "User", foreign_key: :user_id
  has_many :task_reports
end
