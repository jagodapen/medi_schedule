require 'rails_helper'

RSpec.describe Patient, type: :model do
  it { should validate_uniqueness_of :pesel }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :pesel }
  it { should validate_presence_of :birth_date }
end
