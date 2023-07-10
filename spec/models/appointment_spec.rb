require 'rails_helper'

RSpec.describe Appointment, type: :model do
  subject { create :appointment }

  it { should belong_to(:doctor) }
  it { should belong_to(:patient) }

  it { should validate_uniqueness_of(:start_time).scoped_to(:doctor_id) }
  it { should validate_presence_of :doctor_id }
  it { should validate_presence_of :patient_id }
end
