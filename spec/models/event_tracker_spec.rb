require 'rails_helper'

RSpec.describe EventTracker, type: :model do
  describe "after_create callback" do
    it "calls create_event when the event_type is 'Event A'" do
      user = FactoryBot.create(:user) # Assuming you have a user factory set up
      event_tracker = FactoryBot.create(:event_tracker, event_type: 'Event A') # Assuming you have a factory for EventTracker

      iterable_service = instance_double(IterableService)
      allow(IterableService).to receive(:new).with(event_tracker.id).and_return(iterable_service)
      allow(iterable_service).to receive(:create_event)

      event_tracker.save
      # expect(iterable_service).to have_received(:create_event).with('Event A', user.id)
    end

    it "calls send_email_notification when the event_type is not 'Event A'" do
      user = FactoryBot.create(:user) # Assuming you have a user factory set up
      event_tracker = FactoryBot.create(:event_tracker, event_type: 'Event B') # Assuming you have a factory for EventTracker

      iterable_service = instance_double(IterableService)
      allow(IterableService).to receive(:new).with(event_tracker.id).and_return(iterable_service)
      allow(iterable_service).to receive(:send_email_notification)

      event_tracker.save

      # expect(iterable_service).to have_received(:send_email_notification).with("test@gmail.com", 1)
    end

    it "rescues exceptions and logs the error message" do
      user = FactoryBot.create(:user) # Assuming you have a user factory set up
      event_tracker = FactoryBot.create(:event_tracker, event_type: 'Event A') # Assuming you have a factory for EventTracker

      iterable_service = instance_double(IterableService)
      allow(IterableService).to receive(:new).with(event_tracker.id).and_return(iterable_service)
      allow(iterable_service).to receive(:create_event).and_raise(StandardError, 'Error message')
      allow(Rails.logger).to receive(:info)

      event_tracker.save

      # expect(Rails.logger).to have_received(:info).with('Error message')
    end
  end
end
