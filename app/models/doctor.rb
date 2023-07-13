class Doctor < ApplicationRecord
  has_many :appointments

  validates_uniqueness_of :last_name, scope: [:first_name, :faculty]
  validates_presence_of :first_name, :last_name

  def full_name
    "#{ self.first_name } #{ self.last_name }"
  end

  def full_name_with_faculty
    "#{ self.first_name } #{ self.last_name } - #{ self.faculty }"
  end
end
