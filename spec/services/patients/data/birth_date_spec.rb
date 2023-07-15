require 'rails_helper'

RSpec.describe Patients::Data::BirthDate do
  describe ".find" do
    let(:subject_find) { described_class.find(pesel: pesel) }
    
    context "valid string pesel" do
      let(:pesel) { "74120150452" }

      it "returns valid birth date" do
        expect(subject_find).to eq("1974-12-01")
      end
    end

    context "valid integer pesel" do
      let(:pesel) { 88011893755 }

      it "returns valid birth date" do
        subject_find
        expect(subject_find).to eq("1988-01-18")
      end
    end

    context "empty pesel" do
      let(:pesel) { nil }

      it "returns error" do
        expect(subject_find).to be_nil
      end
    end
  end
end
