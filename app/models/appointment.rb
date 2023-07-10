class Appointment < ApplicationRecord
  enum currency: { pln: "PLN", eur: "EUR" }

  belongs_to :patient, counter_cache: true
  belongs_to :doctor

  validates_uniqueness_of :start_time, scope: :doctor_id
  validates_presence_of :patient_id, :doctor_id
end
