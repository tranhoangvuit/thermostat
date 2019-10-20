FactoryBot.define do
  factory :reading do
    association :thermostat, strategy: :build

    sequence(:tracking_number) { |n| "Tracking #{n}" }
    sequence(:temperature)
    sequence(:humidity)
    sequence(:battery_charge)

    trait :invalid do
      tracking_number { '' }
    end
  end
end
