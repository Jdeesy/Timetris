module CalendarAPI

  def api_client
    api_client = Google::APIClient.new
    api_client.authorization.access_token = self.oauth_token
    return api_client
  end

  def events_list(params)
    calendar_api = api_client.discovered_api('calendar', 'v3')
    return api_client.execute(:api_method => calendar_api.events.list, :parameters => params)
  end

  def free_busy(params)
    calendar_api = api_client.discovered_api('calendar', 'v3')
    return api_client.execute(:api_method => calendar_api.freebusy.query, :parameters => params)
  end

  def find_event(index)
    return events_list({'calendarId'    => 'primary',
                        'orderBy'       => 'startTime',
                        'singleEvents'  => 'true',
                        'timeMin'       => Time.now.strftime("%Y-%m-%dT%H:%M:%S.000Z"),
                        'maxResults'    => (1 + index).to_s
                        }).data.items[index]
  end

  def available
    return free_busy({'timeMin'       => Time.now.strftime("%Y-%m-%dT%H:%M:%S.000Z"),
                      'timeMax'       => (Time.now + 86400).strftime("%Y-%m-%dT%H:%M:%S.000Z")
                      }).data
  end

  def next_event
    n = 0
    loop do
      event = find_event(0)
      return event unless event.start.date
      n += 1
    end
  end

  def available?

  end

  def time_to_next_event

  end

end