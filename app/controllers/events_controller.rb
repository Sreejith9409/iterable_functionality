class EventsController < ApplicationController
  def index
    @events = EventTracker.includes(:user).all
  end

  def create_event_a
    event = EventTracker.new(requested_at: Time.now, user_id: current_user.id, is_synced: false, event_type: 'Event A' , is_email_delivered: false)
    respond_to do |format|
      if event.save!
        format.html { redirect_to root_path, notice: 'Event created successfully.' }
      end
    end
  end


  def create_event_b
    event = EventTracker.new(requested_at: Time.now, user_id: current_user.id, is_synced: false, event_type: 'Event B' , is_email_delivered: false)
    respond_to do |format|
      if event.save!
        format.html { redirect_to root_path, notice: 'Event created successfully.' }
      end
    end
  end
end
