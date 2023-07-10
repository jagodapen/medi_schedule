class Doctor < ApplicationRecord
  has_many :appointments

  validates_uniqueness_of :last_name, scope: [:first_name, :faculty]
end
