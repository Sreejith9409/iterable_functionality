class EventTracker < ApplicationRecord
  after_create :call_iterable_event
  belongs_to :user

  private

  def call_iterable_event
    iterable_service = IterableService.new(self.id)
    if self.event_type.eql?('Event A')
      iterable_service.create_event('Event A', user.id)
    else
      iterable_service.send_email_notification(user.email, user.id)
    end
  rescue Exception => message
    Rails.logger.info(message.message)
  end
end
