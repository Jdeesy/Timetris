class User < ActiveRecord::Base
  include CalendarAPI

  has_many :tasks, foreign_key: :creator_id

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.oauth_token = auth.credentials.token
      user.refresh_token = auth.credentials.refresh_token
      user.oauth_expires_at = Time.at(auth.credentials.expires_at)
      user.save
    end
  end

  def refresh_token!
    data = {
      :client_id => GOOGLE_CLIENT_ID,
      :client_secret => GOOGLE_CLIENT_SECRET,
      :refresh_token => self.refresh_token,
      :grant_type => "refresh_token"
    }
    response = ActiveSupport::JSON.decode(RestClient.post "https://accounts.google.com/o/oauth2/token", data)
    if response["access_token"].present?
      self.oauth_token = response["access_token"]
      self.oauth_expires_at = Time.now.utc + response["expires_in"]
      self.save
    end
  end

  def completed_tasks
    self.tasks.select{ |task| task.end_time }
  end

  def pending_tasks
    self.tasks.reject{ |task| task.end_time }
  end

  def possible_tasks
    pending_tasks.select do |task|
      task.time_box <= time_to_next_event
    end
  end

end
