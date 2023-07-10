FactoryBot.define do
  factory :patient do
    sequence(:first_name) { |n| "Patient#{n}" }
    sequence(:last_name) { |n| "LastName#{n}" }
    pesel  { "11111111111" }
    birth_date { "1969/07/02".to_date }
    city { "CITY OF ANGELS" }
    gender { ["female", "male"].sample }
  end
end
