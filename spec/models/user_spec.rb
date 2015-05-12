require 'rails_helper'

RSpec.describe User, type: :model do
  
  describe "User Attributes" do
    user = FactoryGirl.create(:user)
    task = FactoryGirl.create(:task, creator: user)

    it 'should contain a user id' do
      expect(user.id).to be_a(Fixnum)
    end

    it 'should contain a user provider' do
      expect(user.provider).to eq("google")
    end

    it 'should contain a user uid' do
      expect(user.uid).to eq("universal id")
    end

    it 'should contain a user email' do
      expect(user.email).to eq("john.doe@gmail.com")
    end

    it 'should contain a user name' do
      expect(user.name).to eq("John Doe")
    end

    it 'should contain a user oauth_token' do
      expect(user.oauth_token).to eq("oauth token")
    end

    it 'should contain a user oauth_expires_at' do
      expect(user.oauth_expires_at).to be_a(Time)
    end

    it 'should contain a user refresh token' do
      expect(user.refresh_token).to eq("refresh token")
    end

    it 'should contain a default_time_increment' do
      expect(user.default_time_increment).to eq(15)
    end

    it 'should contain a snooze_until Time' do
      expect(user.snooze_until).to be_a(Time)
    end

  end

  describe "User Relationships" do 
    user = FactoryGirl.create(:user)
    task = FactoryGirl.create(:task, creator: user)


    it 'should have many tasks' do
      expect(user.tasks[0]).to eq(task)
    end

  end

  describe "User Instance Methods" do
    user = FactoryGirl.create(:user)
    task = FactoryGirl.create(:task, creator: user)


    it 'should return the number of completed tasks' do
      expect(user.total_count).to eq(1)
    end

    it 'should return total of all time boxes' do
      expect(user.total_time_box).to eq(15)
    end

    it 'should return total of all time boxes' do
      expect(user.total_task_time).to eq(0)
    end

    it 'should return total difference between timebox and actual time' do
      expect(user.total_difference).to eq(15)
    end

    it 'should return average priority' do
      expect(user.average_priority).to eq(2)
    end

    it 'should return average difference' do
      expect(user.average_difference).to eq(15)
    end

    it 'should have alerts enabled by default' do
      expect(user.show_alerts).to be true
    end

    it 'should have alerts disabled if show_alerts is set to false' do
      user.show_alerts = false
      expect(user.show_alerts).to be false
    end
  end

end