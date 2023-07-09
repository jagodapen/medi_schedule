class Patient < ApplicationRecord
  validates_uniqueness_of :pesel_number
  validates_presence_of :first_name, :last_name, :pesel_number, :birth_date
end
