require 'rails_helper'
require 'webmock/rspec'

describe EventsController, type: :controller do

  let(:user) { FactoryBot.create(:user) }

  before do
    sign_in user
    stub_request(:post, "https://api.iterable.com/api/templates/send")
      .to_return(status: 200, body: "", headers: {})
  end

  describe "GET #index" do
    it "returns a list of events" do
      event_a = FactoryBot.create(:event_tracker, :event_a)
      event_b = FactoryBot.create(:event_tracker, :event_b)
      get :index
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST #create_event_a" do
    it "creates Event A" do
      stub_request(:post, "https://api.iterable.com/api/events")
        .to_return(status: 200, body: '{"id": 1, "name": "Event A"}', headers: {})
      post :create_event_a
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq('Event created successfully.')
      created_event = EventTracker.last
      expect(created_event.event_type).to eq('Event A')
      expect(created_event.user_id).to eq(user.id)
      expect(created_event.is_synced).to be_falsey
      expect(created_event.is_email_delivered).to be_falsey
    end
  end

  describe "POST #create_event_b" do
    it "creates Event B" do
      stub_request(:post, "https://api.iterable.com/api/templates/send")
        .to_return(status: 200, body: '{"id": 1, "name": "Event B"}', headers: {})
      post :create_event_b
      expect(response).to redirect_to(root_path)
      expect(flash[:notice]).to eq('Event created successfully.')
      created_event = EventTracker.last
      expect(created_event.event_type).to eq('Event B')
      expect(created_event.user_id).to eq(user.id)
      expect(created_event.is_synced).to be_falsey
      expect(created_event.is_email_delivered).to be_falsey
    end
    
  end
end
