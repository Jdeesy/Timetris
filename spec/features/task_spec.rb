require 'rails_helper'

feature "the redirect process", :type => :feature do
  before :each do
    OmniAuth.config.test_mode = true
    OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({
      :provider     =>    "google",
      :uid => '1234567',
      :info => {
      :name      =>       "John Doe",
      :email      =>      "john.doe@gmail.com"
      }
     })

   #  OmniAuth.config.on_failure = Proc.new { |env|
   #   OmniAuth::FailureEndpoint.new(env).redirect_to_failure
   # }
   # visit '/auth/google'

    # user = FactoryGirl.create(:user)
    # task = FactoryGirl.create(:task, creator: user)

    # event_1 = OpenStruct.new('start' => OpenStruct.new("dateTime" => DateTime.iso8601('2015-05-12T11:30:00-05:00')), 'end' => OpenStruct.new("dateTime" => DateTime.iso8601('2015-05-12T12:00:00-05:00')))
  end

  scenario "redirects me to root page" do
      visit root_path
      click_link "Sign in with Google+"
      expect(page).to have_link "Ok"
  end
end