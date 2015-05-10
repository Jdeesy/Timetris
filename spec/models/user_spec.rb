require 'rails_helper'

RSpec.describe User, type: :model do
  user = FactoryGirl.create(:user)
  task = FactoryGirl.create(:task)
  
  describe "User Model Methods" do
    it 'should return a user id' do
      expect(user.id).to be_a(Fixnum)
    end

    it 'should return a user provider' do
      expect(user.provider).to eq("google")
    end

    it 'should return a user uid' do
      expect(user.uid).to eq("universal id")
    end

    it 'should return a user email' do
      expect(user.name).to eq("john.doe@gmail.com")
    end

    it 'should return a user name' do
      expect(user.name).to eq("John Doe")
    end

    it 'should return a user oauth_token' do
      expect(user.oauth_token).to eq("oauth token")
    end

    it 'should return a user oauth_expires_at' do
      expect(user.oauth_expires_at).to be_a(Time)
    end

    it 'should return a user refresh token' do
      expect(user.refresh_token).to eq("refresh token")
    end

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

    it 'should return average priority' do
      expect(user.average_difference).to eq(15)
    end           
  end

  describe "User Relationships" do 
    it 'should return the user' do
      expect(user.tasks[0].creator).to eq(user)
    end
  end
end