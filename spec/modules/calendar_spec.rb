require 'rails_helper'

RSpec.describe CalendarAPI do
  before(:each) do

    auth = OpenStruct.new('provider' => 'google', 'uid' => 'uid', 'credentials' => OpenStruct.new('token' => '12345', 'refresh_token' => '111111111a', 'expires_at' => Time.now + 360), 'info' => OpenStruct.new('name' => 'test', 'email' => 'test@test.com'))

    @user = User.from_omniauth(auth)

    @event_1 = OpenStruct.new('start' => OpenStruct.new("dateTime" => Time.now.to_i + 1800), 'end' => OpenStruct.new("dateTime" => Time.now.to_i + 3600))
    @event_3 = OpenStruct.new('start' => OpenStruct.new("dateTime" => Time.now.to_i - 1), 'end' => OpenStruct.new("dateTime" => nil))
    @event_2 = OpenStruct.new('start' => OpenStruct.new("dateTime" => DateTime.iso8601("2015-05-14T13:30:00-05:00")), 'end' => OpenStruct.new("dateTime" => DateTime.iso8601("2015-05-14T15:30:00-05:00")))

    @events = [@event_1, @event_2, @event_3]
  end

  describe "#time_to_next_event" do

    it "returns the time to the next event when as a float when passed an array of upcoming events" do
      expect(@user.time_to_next_event(@events)).to be_a(Float)
    end

    it "returns the time in minutes to the next event when passed an array of upcoming events" do
      expect(@user.time_to_next_event(@events).round).to eq(30)
    end

    it "returns 0 when a user is currently in an event" do
      @events.delete(@event_1)
      @events.delete(@event_2)
      expect(@user.time_to_next_event(@events).round).to eq(0)
    end

    it "returns the time 24 hrs in minutes when passed an empty array of upcoming events" do
      @events.clear
      expect(@user.time_to_next_event(@events).round).to eq(1440)
    end
  end

end