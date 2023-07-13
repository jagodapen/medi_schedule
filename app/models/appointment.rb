class Appointment < ApplicationRecord
  DEFAULT_CURRENCY = "pln".freeze
  DEFAULT_DURATION = 20.freeze

  enum currency: { pln: "PLN", eur: "EUR" }

  belongs_to :patient, counter_cache: true
  belongs_to :doctor

  validates_uniqueness_of :start_time, scope: :doctor_id
  validates_presence_of :patient_id, :doctor_id

  def self.ransackable_attributes(auth_object = nil)
    ["patient_id", "doctor_id"]
  end
end
