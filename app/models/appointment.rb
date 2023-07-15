class Appointment < ApplicationRecord
  before_save :validate_datetime

  DEFAULT_CURRENCY = "pln".freeze
  DEFAULT_DURATION = 20.freeze
  DEFAULT_START_TIME = 8.freeze
  DEFAULT_END_TIME = 16.freeze

  belongs_to :patient, counter_cache: true
  belongs_to :doctor

  validates_uniqueness_of :start_time, scope: :doctor_id
  validates_presence_of :patient_id, :doctor_id
  validate :validate_datetime

  def self.ransackable_attributes(auth_object = nil)
    ["patient_id", "doctor_id"]
  end

  private

  def validate_datetime
    Appointments::Validators::Date.new(day: start_time).call

  rescue  Appointments::Validators::Date::InvalidDate => e
    errors.add(:start_time, message: e)
  end
end
