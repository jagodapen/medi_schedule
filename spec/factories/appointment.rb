FactoryBot.define do
  factory :appointment do
    patient { create :patient }
    doctor { create :doctor }
    start_time { "2024/07/02 08:00:00".to_datetime }
    duration  { 20 }
    cost { 100 }
    currency { "PLN" }
  end
end
