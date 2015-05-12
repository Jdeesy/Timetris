FactoryGirl.define do
  factory :user do
    provider         "google"
    uid              "universal id"
    email            "john.doe@gmail.com"
    name             "John Doe"
    oauth_token      "oauth token"
    oauth_expires_at Time.now
    refresh_token    "refresh token"
  end

  factory :task do
    name        "Do cool stuff"
    time_box    15   
    due_date    Time.now
    start_time  Time.now
    end_time    Time.now
    event_id    "google event id"
    priority    2
    description "task description"
  end


end