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
      user.alerts_enabled = false
      expect(user.show_alerts).to be false
    end
  end

  describe "testing the sorting of events" do
    user = FactoryGirl.create(:user)
    let!( :event_1 ){OpenStruct.new('start' => OpenStruct.new("dateTime" => DateTime.iso8601('2015-05-12T11:30:00-05:00')), 'end' => OpenStruct.new("dateTime" => DateTime.iso8601('2015-05-12T12:00:00-05:00')))}
    let!( :event_2 ){OpenStruct.new('start' => OpenStruct.new("dateTime" => DateTime.iso8601("2015-05-12T13:30:00-05:00")), 'end' => OpenStruct.new("dateTime" => DateTime.iso8601("2015-05-12T15:30:00-05:00")))}
    let!( :events ){ [event_1, event_2] }

    xit 'should return the array count of 2' do
      expect(events.count).to eq(2)
    end

    xit 'should return the array count of 4' do
      expect(user.sort_upcoming_events(events).count).to eq(4)
    end

    xit 'should return start for first event' do
      expect(user.sort_upcoming_events(events)[0][0]).to eq(:start)
    end

    xit 'should return time of the first event' do
      expect(user.sort_upcoming_events(events)[0][2]).to eq(DateTime.iso8601("2015-05-12T11:30:00-05:00").to_i)
    end

    xit 'should return end for last event' do
      expect(user.sort_upcoming_events(events)[3][0]).to eq(:end)
    end

    xit 'should return time of the last event' do
      expect(user.sort_upcoming_events(events)[3][2]).to eq(DateTime.iso8601("2015-05-12T15:30:00-05:00").to_i)
    end
  end

end