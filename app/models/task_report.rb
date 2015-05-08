class TaskReport < ActiveRecord::Base
  include CalendarAPI

  belongs_to :task
  has_one :creator, through: :task
end
