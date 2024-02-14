FactoryBot.define do
  factory :event_tracker do
    requested_at { Time.now }
    user_id { 1 }
    is_synced { false }
    is_email_delivered { false}
    trait :event_a do
      event_type { "Event A" }
    end
    trait :event_b do
      event_type { "Event B" }
    end
  end
end