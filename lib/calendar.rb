module CalendarAPI

  def api_client
    self.refresh_token! if Time.at(self.oauth_expires_at).utc <= Time.now.utc
    api_client = Google::APIClient.new
    api_client.authorization.access_token = self.oauth_token
    api_client.authorization.refresh_token = self.refresh_token
    return api_client
  end

  def events_list(params)
    calendar_api = api_client.discovered_api('calendar', 'v3')
    return api_client.execute(:api_method => calendar_api.events.list,
                              :parameters => params)
  end

  def events_insert(body)
    calendar_api = api_client.discovered_api('calendar', 'v3')
    return api_client.execute(:api_method => calendar_api.events.insert,
                              :parameters => {'calendarId' => 'primary'},
                              :body       => JSON.dump(body),
                              :headers    => {'Content-Type' => 'application/json'})
  end

  def events_patch(params, body)
    calendar_api = api_client.discovered_api('calendar', 'v3')
    return api_client.execute(:api_method => calendar_api.events.patch,
                              :parameters => params,
                              :body       => JSON.dump(body),
                              :headers    => {'Content-Type' => 'application/json'})
  end

  def upcoming_events
    start_time = Time.now.utc.strftime("%Y-%m-%dT%H:%M:%S.000Z")
    end_time = (Time.now.utc + 86400).strftime("%Y-%m-%dT%H:%M:%S.000Z")
    return events_list({'calendarId'    => 'primary',
                        'orderBy'       => 'startTime',
                        'singleEvents'  => 'true',
                        'timeMin'       => start_time,
                        'timeMax'       => end_time
                        }).data.items.select { |event| event.start['dateTime'] }
  end

  def time_to_next_event(events)
    if events.any?
      if Time.at(events[0].start['dateTime']).utc > Time.now.utc
        return (Time.at(events[0].start['dateTime']) - Time.now.utc)/60
      else
        return 0
      end
    else
      return 1440
    end
  end

  def begin_task(task)
    start_time = Time.now.utc.strftime("%Y-%m-%dT%H:%M:%S.000Z")
    end_time = (Time.now.utc + (task.time_box * 60)).strftime("%Y-%m-%dT%H:%M:%S.000Z")
    summary = task.name
    return events_insert({'start'   => {'dateTime' => start_time},
                           'end'     => {'dateTime' => end_time},
                           'summary' => summary
                          }).data
  end

  def complete_task(task)
    end_time = Time.now.utc.strftime("%Y-%m-%dT%H:%M:%S.000Z")
    return events_patch({'calendarId' => 'primary',
                          'eventId'    => task.event_id},
                         {'end'        => {'dateTime' => end_time}}
                         ).data
  end

  def complete_calendar_event(calendar_event)
    end_time = Time.now.utc.strftime("%Y-%m-%dT%H:%M:%S.000Z")
    return events_patch({'calendarId' => 'primary',
                          'eventId'    => calendar_event.id},
                         {'end'        => {'dateTime' => end_time}}
                         ).data
  end
end
