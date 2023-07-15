require 'rails_helper'

RSpec.describe Patients::Validators::Pesel do
  describe ".find" do
    subject { described_class.new(pesel: pesel) }
    let(:pesel) { "#{year}#{month}#{day}12345"}
    let(:month) { "12" }
    let(:day) { "25" }
    let(:year) { "74" }
    
    context "valid" do
      it "returns true" do
        expect(subject.call).to be_truthy
      end
    end

    context "invalid_pesel" do
      context "invalid century" do
        let(:month) { "42" }

        it "returns error" do
          expect { subject.call }.to raise_error(Patients::Validators::Pesel::InvalidPesel)
        end
      end

      context "invalid month" do
        let(:month) { "15" }

        it "returns error" do
          expect { subject.call }.to raise_error(Patients::Validators::Pesel::InvalidPesel)
        end
      end

      context "invalid february day" do
        let(:month) { "02" }
        let(:day) { "30" }

        it "returns error" do
          expect { subject.call }.to raise_error(Patients::Validators::Pesel::InvalidPesel)
        end
      end

      context "invalid month day" do
        let(:day) { "45" }

        it "returns error" do
          expect { subject.call }.to raise_error(Patients::Validators::Pesel::InvalidPesel)
        end
      end

      context "invalid age of patient" do
        let(:month) { "88" }

        it "returns error" do
          expect { subject.call }.to raise_error(Patients::Validators::Pesel::IncrediblyOld)
        end
      end
    end
  end
end
