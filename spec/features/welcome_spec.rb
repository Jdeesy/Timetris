# describe "the signin process", :type => :feature do
#   before :each do
#     # User.make(:email => 'user@example.com', :password => 'password')
#       OmniAuth.config.test_mode = true
#     @test = OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({
#       :provider => 'google',
#       :uid => '123545',
#       :info => {
#                         'name' => 'JonnieHallman',
#                           'email' => 'jon@test.com'
#                                                             }

#     })
#     Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google]
#     # Capybara.current_driver = :selenium

#   end

#   it "signs me in" do
#     # visit "/auth/google_oauth2/callback"
#     @test
#     expect(page).to have_content('Google')

#     visit '/past'
#     expect(page).to have_content('On average')
#     # within("#session") do
#     # end
#     # click_link 'Sign in with Google+'
#     # expect(page.current_path).to eq("/auth/google_oauth2/callback")
#   end
# end

#   # it 'shoud do this' do
#   #   OmniAuth.config.test_mode = true
#   #   OmniAuth.config.mock_auth[:google] = OmniAuth::AuthHash.new({
#   #     :provider => 'google',
#   #     :uid => '123545',
#   #     :info => {
#   #                       'name' => 'JonnieHallman',
#   #                         'email' => 'jon@test.com'
#   #                                                           }

#   #   })
#   #   Rails.application.env_config["omniauth.auth"] = OmniAuth.config.mock_auth[:google]

#   # end