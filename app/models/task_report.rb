class TaskReport < ActiveRecord::Base
  belongs_to :task
  has_one :user, through: :task, source: :creator
end
