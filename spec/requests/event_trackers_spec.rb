require 'rails_helper'

RSpec.describe IterableService do
  let(:event_tracker) { instance_double(EventTracker) }
  let(:iterable_service) { IterableService.new(1) }

  before do
    allow(EventTracker).to receive(:find_by).with(id: 1).and_return(event_tracker)
    allow(event_tracker).to receive(:update!)
  end

  describe "#create_event" do
    it "creates an event and updates is_synced when the API call is successful" do
      allow(iterable_service).to receive(:post).and_return(double(code: 200))

      response = iterable_service.create_event('event_name', 'user_id')

      expect(response.code).to eq(200)
      expect(event_tracker).to have_received(:update!).with(is_synced: true)
    end

    it "does not update is_synced when the API call fails" do
      allow(iterable_service).to receive(:post).and_return(double(code: 500))

      response = iterable_service.create_event('event_name', 'user_id')

      expect(response.code).to eq(500)
      expect(event_tracker).not_to have_received(:update!)
    end
  end

  describe "#send_email_notification" do
    it "sends an email notification and updates is_synced and is_email_delivered when the API call is successful" do
      allow(iterable_service).to receive(:post).and_return(double(code: 200))

      response = iterable_service.send_email_notification('email@example.com', 'user_id')

      expect(response.code).to eq(200)
      expect(event_tracker).to have_received(:update!).with(is_synced: true, is_email_delivered: true)
    end

    it "does not update is_synced and is_email_delivered when the API call fails" do
      allow(iterable_service).to receive(:post).and_return(double(code: 500))

      response = iterable_service.send_email_notification('email@example.com', 'user_id')

      expect(response.code).to eq(500)
      expect(event_tracker).not_to have_received(:update!)
    end
  end

  describe "#post" do
    let(:iterable_service) { IterableService.new(1) }

    it "sends a POST request to the specified URL and returns the response" do
      url = "/test"
      request_hash = { key: "value" }
      headers_hash = { "Authorization" => "Bearer token" }
      response_body = { success: true }.to_json

      allow(RestClient::Request).to receive(:execute).and_return(double(body: response_body))

      response = iterable_service.send(:post, url, request_hash, headers_hash)

      expect(RestClient::Request).to have_received(:execute).with(
        method: :post,
        url: "https://api.iterable.com/api/test",
        payload: { key: "value" }.to_json,
        verify_ssl: OpenSSL::SSL::VERIFY_NONE,
        headers: { "Authorization" => "Bearer token", "Content-Type" => "application/json" }
      )
      expect(response).to eq({ "success" => true })
    end

    it "handles exceptions and logs the response body" do
      url = "/test"
      request_hash = { key: "value" }
      headers_hash = { "Authorization" => "Bearer token" }

      allow(RestClient::Request).to receive(:execute).and_raise(RestClient::Exception.new(double(response: double(body: "Error response"))))

      expect { iterable_service.send(:post, url, request_hash, headers_hash) }.to output("Error response\n").to_stdout
    end
  end
end
