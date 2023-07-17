class Patient < ApplicationRecord
  before_save :validate_pesel
  
  enum gender: { female: "female", male: "male" }

  has_many :appointments, dependent: :destroy

  validates_uniqueness_of :pesel
  validates_presence_of :first_name, :last_name, :pesel, :birth_date
  validate :validate_pesel

  def self.ransackable_attributes(auth_object = nil)
    ["appointments_count", "birth_date", "city", "first_name", "gender", "last_name", "pesel"]
  end

  def full_name
    "#{ self.first_name } #{ self.last_name }"
  end

  private

  def validate_pesel
    validation_errors = Patients::Validators::Pesel.new(pesel: pesel).call
    unless validation_errors.empty?
      errors.add(:pesel, validation_errors.first)
    end
  end
end
