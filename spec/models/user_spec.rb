require 'rails_helper'

RSpec.describe User, type: :model do
  user = FactoryGirl.create(:user)
  # let!( :user ){ User.create!(provider: "provider_string", uid: "user_id_string", name: "John", oauth_token: "token_string", oauth_expires_at: Time.now) }
  # let!( :task ){ Task.create!(creator: user, name: 'task', due_date: Time.now, start_time: Time.now, end_time: Time.now) }
  
  describe "User Model Methods" do
    it 'should return a user id' do
      expect(user.id).to be_a(Fixnum)
    end

    # it 'should return a user provider' do
    #   expect(user.provider).to eq("provider_string")
    # end

    # it 'should return a user uid' do
    #   expect(user.uid).to eq("user_id_string")
    # end

    # it 'should return a user name' do
    #   expect(user.name).to eq("John")
    # end

    # it 'should return a user oauth_token' do
    #   expect(user.oauth_token).to eq("token_string")
    # end

    # it 'should return a user oauth_expires_at' do
    #   expect(user.oauth_expires_at).to be_a(Time)
    # end
  end

  describe "User Relationships" do 
    # it 'should return the user' do
    #   expect(user.tasks[0].creator).to eq(user)
    # end
  end
end