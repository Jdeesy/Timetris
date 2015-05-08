class TaskReport < ActiveRecord::Base
  belongs_to :task
  has_one :creator, through: :task
end
