require 'rails_helper'

RSpec.describe Task, type: :model do
  # let!( :user ){ User.create!(provider: "provider_string", uid: "user_id_string", name: "John", oauth_token: "token_string", oauth_expires_at: Time.now) }
  # let!( :task ){ Task.create!(creator: user, name: 'task', due_date: Time.now, start_time: Time.now, end_time: Time.now) }
  
  # describe "Task Model Methods" do
  #   it 'should return a task id' do
  #     expect(task.id).to be_a(Fixnum)
  #   end

  #   it 'should return a task time box' do
  #     expect(task.time_box).to eq(15)
  #   end

  #   it 'should return a task due date' do
  #     expect(task.due_date).to be_a(Time)
  #   end

  #   it 'should return a time' do
  #     expect(task.start_time).to be_a(Time)
  #   end

  #   it 'should return a time' do
  #     expect(task.end_time).to be_a(Time)
  #   end
  # end

  # describe "task Relationships" do 
  #   it 'should return the user' do
  #     expect(task.creator).to be(user)
  #   end
  # end
end
