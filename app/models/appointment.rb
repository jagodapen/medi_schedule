class Appointment < ApplicationRecord
  enum currency: { pln: "PLN", eur: "EUR" }

  belongs_to :patient, counter_cache: true
  belongs_to :doctor
end
