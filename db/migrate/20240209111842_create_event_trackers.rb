class CreateEventTrackers < ActiveRecord::Migration[7.1]
  def change
    create_table :event_trackers do |t|
      t.datetime :requested_at
      t.references :user
      t.boolean :is_synced
      t.string :event_type
      t.boolean :is_email_delivered

      t.timestamps
    end
  end
end
