FactoryBot.define do
  factory :doctor do
    sequence(:first_name) { |n| "Doctor#{n}" }
    sequence(:last_name) { |n| "Shepherd#{n}" }
    faculty  { "INTERNISTA" }
  end
end
