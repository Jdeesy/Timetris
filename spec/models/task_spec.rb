require 'rails_helper'

RSpec.describe Task, type: :model do
  user = FactoryGirl.create(:user)
  task = FactoryGirl.create(:task, creator: user)
  
  describe "Task Model Methods" do
    it 'should return a task id' do
      expect(task.id).to be_a(Fixnum)
    end

    it 'should return a task name' do
      expect(task.name).to eq("Do cool stuff")
    end

    it 'should return a task time box' do
      expect(task.time_box).to eq(15)
    end

    it 'should return a task due date' do
      expect(task.due_date).to be_a(Time)
    end

    it 'should return a time' do
      expect(task.start_time).to be_a(Time)
    end

    it 'should return a time' do
      expect(task.end_time).to be_a(Time)
    end

    it 'should return a task event id' do
      expect(task.event_id).to eq("google event id")
    end

    it 'should return a task priority' do
      expect(task.priority).to eq(2)
    end

    it 'should return a task target time' do
      expect(task.target_finish_time).to eq(Time.at(task.start_time).utc + (task.time_box * 60))
    end

    it 'should return a task time' do
      expect(task.task_time).to eq(0)
    end

    it 'should return the difference between task time and time box' do
      expect(task.difference).to eq(15)
    end

    it 'should return the difference between task time and time box in words' do
      expect(task.time_box_difference).to eq("15 minutes under")
    end

    it 'should return false since no task is in progress' do
      expect(task.task_in_progress).to be false
    end            
  end

  describe "task Relationships" do 
    it 'should return the user' do
      expect(task.creator).to be(user)
    end
  end
end
