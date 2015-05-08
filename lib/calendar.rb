module CalendarAPI

  def api_client
    api_client = Google::APIClient.new
    api_client.authorization.access_token = current_user.oauth_token
    return api_client
  end

  def events_list(params)
    calendar_api = api_client.discovered_api('calendar', 'v3')
    return api_client.execute(:api_method => calendar_api.events.list, :parameters => params)
  end

  def next_event
    return events_list({'calendarId'    => 'primary',
                        'orderBy'       => 'startTime',
                        'singleEvents'  => 'true',
                        'timeMin'       => Time.now.strftime("%Y-%m-%dT%H:%M:%S.000Z"),
                        'maxResults'    => '1'
                        })
  end

  def time_to_next_event

  end

  def available?

  end

end