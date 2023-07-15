require 'rails_helper'

RSpec.describe Patients::Data::Gender do
  describe ".find" do
    let(:subject_find) { described_class.find(pesel: pesel) }
    
    context "women's pesel" do
      let(:pesel) { "74120150422" }

      it "returns correct gender" do
        expect(subject_find).to eq("female")
      end
    end

    context "men's pesel" do
      let(:pesel) { "74120150432" }

      it "returns correct gender" do
        expect(subject_find).to eq("male")
      end
    end
  end
end
