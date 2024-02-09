require 'rails_helper'

RSpec.describe "EventTrackers", type: :request do

  let(:iterable_service) { IterableService.new(1) }

  describe 'Iterable API interactions' do
    it 'performs a request to iterable.com' do
      VCR.use_cassette('create_event') do
        event_data = { name: 'Event A' }
        response = iterable_service.create_event('Event A', 1)
        expect(response.code).to eq(200)
        expect(JSON.parse(response.body)['success']).to be true
      end
    end
  end
end
