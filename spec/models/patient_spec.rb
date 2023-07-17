require 'rails_helper'

RSpec.describe Patient, type: :model do
  it { should have_many(:appointments).dependent(:destroy) }
  
  it { should validate_uniqueness_of :pesel }
  it { should validate_presence_of :first_name }
  it { should validate_presence_of :last_name }
  it { should validate_presence_of :pesel }
  it { should validate_presence_of :birth_date }

  describe "before_save pesel validation" do
    context "valid pesel" do
      let(:patient) { build :patient }

      it "saves patient" do
        expect { patient.save }.to change(Patient, :count).by(1)
      end
    end
    
    context "invalid pesel" do
      let(:patient) { build :patient, pesel: pesel }
      let(:pesel) { "12345678910" }

      it "does not save patient" do
        expect { patient.save }.not_to change(Patient, :count)
      end
    end
  end
end
