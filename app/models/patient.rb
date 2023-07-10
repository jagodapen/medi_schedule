class Patient < ApplicationRecord
  enum gender: { female: "female", male: "male" }
  validates_uniqueness_of :pesel
  validates_presence_of :first_name, :last_name, :pesel, :birth_date
end
