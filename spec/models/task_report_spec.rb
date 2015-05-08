require 'rails_helper'

RSpec.describe TaskReport, type: :model do
  let!( :user ){ User.create!(name: "John" }
  let!( :task ){ Task.create!(creator: user) }
  let!( :task_report ){ TaskReport.create!(task: task) }
  
  # describe "Task Model Methods" do
  #   it 'should return a task id' do
  #     expect(task.id).to be_a(Fixnum)
  #   end

  #   it 'should return a task time box' do
  #     expect(task.time_box).to eq(15)
  #   end

  #   it 'should return a task due date' do
  #     expect(task.uid).to be_a(Time)
  #   end
  # end

  # describe "task Relationships" do 
  #   if 'should return the user' do
  #     expect(task.creator).to be(user)
  #   end

  #   if 'should return the task' do
  #     expect(task.task_reports[0].task).to be(task)
  #   end
  # end
end
