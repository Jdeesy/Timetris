require 'rails_helper'
require 'ostruct'

RSpec.describe 'Helper' do
  user = FactoryGirl.create(:user)
  let!( :events ){ [] }
  
  before(:each) do
    
    event_1 = OpenStruct.new('start' => OpenStruct.new("dateTime" => DateTime.iso8601('2015-05-12T11:30:00-05:00')), 'end' => OpenStruct.new("dateTime" => DateTime.iso8601('2015-05-12T12:00:00-05:00')))

    event_2 = OpenStruct.new('start' => OpenStruct.new("dateTime" => DateTime.iso8601("2015-05-12T13:30:00-05:00")), 'end' => OpenStruct.new("dateTime" => DateTime.iso8601("2015-05-12T15:30:00-05:00")))

    events << event_1
    events << event_2
  end

  describe "testing the sorting of events" do
    it 'should return the array count of 2' do
      expect(events.count).to eq(2)
    end

    it 'should return the array count of 4' do
      expect(user.sort_upcoming_events(events).count).to eq(4)
    end

    it 'should return start for first event' do
      expect(user.sort_upcoming_events(events)[0][0]).to eq(:start)
    end

    it 'should return time of the first event' do
      expect(user.sort_upcoming_events(events)[0][2]).to eq(DateTime.iso8601("2015-05-12T11:30:00-05:00").to_i)
    end

    it 'should return end for last event' do
      expect(user.sort_upcoming_events(events)[3][0]).to eq(:end)
    end

    it 'should return time of the last event' do
      expect(user.sort_upcoming_events(events)[3][2]).to eq(DateTime.iso8601("2015-05-12T15:30:00-05:00").to_i)
    end
  end

  describe "Calculate Gap Time" do
    it 'should return time between events' do
      expect(user.calculate_gap_time([DateTime.iso8601("2015-05-12T12:00:00-05:00").to_i,DateTime.iso8601("2015-05-12T13:30:00-05:00").to_i])).to eq([1431450000, 5400])
    end
  end

  describe "Find the gaps" do
    it 'should return an array with gap start time and duration' do
      expect(user.find_the_gaps(user.sort_upcoming_events(events))).to eq([[1431450000, 5400]])
    end
  end
end