require 'rails_helper'

describe EventsController, type: :controller do
  before do
    stub_request(:post, "https://api.iterable.com/api/events")
      .to_return(status: 200, body: "", headers: {})
    stub_request(:post, "https://api.iterable.com/api/templates/send")
      .to_return(status: 200, body: "", headers: {})
  end

  describe "POST #create_event_a" do
    it "creates Event A" do
      post :create_event_a
      binding.pry
      expect(response).to have_http_status(:success)
      # Add more expectations here if needed
    end
  end

  describe "POST #create_event_b" do
    it "creates Event B" do
      post :create_event_b
      expect(response).to have_http_status(:success)
      # Add more expectations here if needed
    end

    it "sends email notification for Event B" do
      expect {
        post :create_event_b
      }.to change { ActionMailer::Base.deliveries.count }.by(1)
    end
  end
end
