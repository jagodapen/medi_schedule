class Patient < ApplicationRecord
  enum gender: { female: "female", male: "male" }

  has_many :appointments

  validates_uniqueness_of :pesel
  validates_presence_of :first_name, :last_name, :pesel, :birth_date
end
