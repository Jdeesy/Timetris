require 'rails_helper'

RSpec.describe TaskReport, type: :model do
  let!( :user ){ User.create!(name: "John" ) }
  let!( :task ){ Task.create!(creator: user) }
  let!( :task_report ){ TaskReport.create!(task: task, start_time: Time.now, end_time: Time.now) }
  
  describe "TaskReport Model Methods" do
    it 'should return a task_report id' do
      expect(task_report.id).to be_a(Fixnum)
    end

    it 'should return a time' do
      expect(task_report.start_time).to be_a(Time)
    end

    it 'should return a time' do
      expect(task_report.end_time).to be_a(Time)
    end
  end

  describe "task Relationships" do 
    it 'should return the user' do
      expect(task_report.creator).to eq(user)
    end

    it 'should return the task' do
      expect(task_report.task).to eq(task)
    end
  end
end