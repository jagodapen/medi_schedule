FactoryBot.define do
  factory :appointment do
    patient { create :patient }
    doctor { create :doctor }
    start_time { Date.today.to_datetime.in_time_zone("Europe/Warsaw").next_week.change(hour: rand(8..15), min: [0, 20, 40].sample) + rand(0..4).days }
    duration  { 20 }
    cost { 100 }
    currency { "PLN" }

    trait :skip_validation do
      to_create {|instance| instance.save(validate: false) }
    end
  end
end
