class Doctor < ApplicationRecord
  validates_uniqueness_of :last_name, scope: [:first_name, :faculty]
end
