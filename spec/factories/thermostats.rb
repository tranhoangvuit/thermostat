FactoryBot.define do
  factory :thermostat do
    sequence(:household_token) { |n| "HouseHold_Token #{n}" }
    sequence(:location) { |n| "Location #{n}" }

    trait :invalid do
      household_token { '' }
      location { '' }
    end
  end
end
