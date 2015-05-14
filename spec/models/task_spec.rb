require 'rails_helper'

RSpec.describe Task, type: :model do
    let (:user) {FactoryGirl.create(:user)}
    let (:task) {FactoryGirl.create(:task, creator: user)}

  describe "Task Attributes" do
    user = FactoryGirl.create(:user)
    task = FactoryGirl.create(:task, creator: user)

    it 'should have a task id' do
      expect(task.id).to be_a(Fixnum)
    end

    it 'should have a task name' do
      expect(task.name).to eq("Do cool stuff")
    end

    it 'should have a default time box of 15' do
      expect(task.time_box).to eq(15)
    end

    it 'should have a task due date' do
      expect(task.due_date).to be_a(Time)
    end

    it 'should have a start time' do
      expect(task.start_time).to be_a(Time)
    end

    it 'should have an end time' do
      expect(task.end_time).to be_a(Time)
    end

    it 'should have an event id' do
      expect(task.event_id).to eq("google event id")
    end

    it 'should have a default priority of 2' do
      expect(task.priority).to eq(2)
    end

    it 'should have a description' do
      expect(task.description).to eq("task description")
    end

    it 'should have a task target finish time' do
      expect(task.target_finish_time).to eq(Time.at(task.start_time).utc + (task.time_box * 60))
    end

    it 'should have a task time' do
      expect(task.duration).to eq(0)
    end

    it 'should return the difference between task time and time box' do
      expect(task.time_box_difference).to eq(15)
    end

    it 'should return the difference between task time and time box in words' do
      expect(task.time_box_difference_in_words).to eq("15 min under")
    end

    it 'should return false since no task is in progress' do
      expect(task.task_in_progress).to be false
    end

    it 'should return true if a task is in progress' do
      task.update(end_time: nil)
      expect(task.task_in_progress).to be true
    end
  end

  describe "Task Relationships" do
    user = FactoryGirl.create(:user)
    task = FactoryGirl.create(:task, creator: user)
    it 'should belong to a creator' do
      expect(task.creator).to be(user)
    end
  end

  describe "Task#time_box_subtract" do
    it 'should subtract the default timebox amount from the task' do
      user.update(default_time_increment: 30)
      expect{task.time_box_subtract}.to change{task.time_box}.by(-30)
    end

    it 'should subtract the default timebox amount from the task' do
      user.update(default_time_increment: 97)
      expect{task.time_box_subtract}.to change{task.time_box}.by(-97)
    end

    it 'should not decrease the task timebox if already the lowest time' do
      task.time_box_subtract
      expect{task.save}.to change{task.time_box}.by(0)
    end
  end

  describe "Task#time_box_add" do
    it 'should add the default timebox amount from the task' do
      user.update(default_time_increment: 30)
      expect{task.time_box_add}.to change{task.time_box}.by(30)
    end

    it 'should add the default timebox amount from the task' do
      user.update(default_time_increment: 97)
      expect{task.time_box_add}.to change{task.time_box}.by(97)
    end

    it 'should not increase the task timebox if already the highest time' do
      task.update(time_box: 1439)
      task.time_box_add
      expect{task.save}.to change{task.time_box}.by(0)
    end
  end

  describe "Task#priority_add" do
    it 'should increase the task priority' do
      expect{task.priority_add}.to change{task.priority}.from(2).to(1)
    end

    it 'should not increase the task priority if already the highest priority' do
      task.update(priority: 1)
      task.priority_add
      expect{task.save}.to change{task.priority}.by(0)
    end
  end
end
