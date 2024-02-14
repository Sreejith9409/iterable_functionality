class IterableService
  # include HTTParty
  BASE_URL = 'https://api.iterable.com/api'

  def initialize(event_id)
    @event = EventTracker.find_by(id: event_id)
  end

  def create_event(event_name, user_id)
    response = post("/events", {
      body: {
        apiKey: @api_key,
        eventName: event_name,
        userId: user_id
      }
    })
    if response.code.eql?(200)
      @event.update!(is_synced: true) if @event.present?
    end
    response
  end

  def send_email_notification(email, user_id)
    response = post("/templates/send", {
      body: {
        apiKey: @api_key,
        recipientEmail: email,
        user_id: user_id
      }
    })
    if response.code.eql?(200)
      @event.update!(is_synced: true, is_email_delivered: true) if @event.present?
    end
    response
  end

  def post(url, request_hash, headers_hash = {})
    begin
      request_url = BASE_URL + url
      headers_hash["Content-Type"] = 'application/json'
      resp = RestClient::Request.execute(method: :post, url: request_url, payload: request_hash.to_json, verify_ssl: OpenSSL::SSL::VERIFY_NONE, headers: headers_hash)
      if response.present?
        response = JSON.parse(resp.body)
      end
    rescue => exception
      # response = exception.response
      Rails.logger.info(exception.message)
    end
    response
  end
end