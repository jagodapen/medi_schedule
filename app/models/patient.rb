class Patient < ApplicationRecord
  enum gender: { female: "female", male: "male" }

  has_many :appointments, dependent: :destroy

  validates_uniqueness_of :pesel
  validates_presence_of :first_name, :last_name, :pesel, :birth_date

  def self.ransackable_attributes(auth_object = nil)
    ["appointments_count", "birth_date", "city", "first_name", "gender", "last_name", "pesel"]
  end

  def full_name
    "#{ self.first_name } #{ self.last_name }"
  end
end
