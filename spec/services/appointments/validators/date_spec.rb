require 'rails_helper'

RSpec.describe Appointments::Validators::Date do
  describe ".call" do
    subject { described_class.new(day: start_time) }
    
    context "valid appointment date" do
      let(:start_time) { DateTime.now.next_week.change(hour: Appointment::DEFAULT_START_TIME) }

      it "returns empty array" do
        expect(subject.call).to be_a Array
        expect(subject.call).to be_empty
      end
    end

    context "invalid appointment date" do
      context "date in past" do
        let(:start_time) { DateTime.now.change(hour: Appointment::DEFAULT_START_TIME).last_weekday }

        it "returns array with errors" do
          expect(subject.call).to include("Select future date")
        end
      end

      context "weekend day" do
        let(:start_time) { DateTime.now.change(hour: Appointment::DEFAULT_START_TIME).beginning_of_week + 6.days }

        it "returns array with errors" do
          expect(subject.call).to include("Meeting can't be scheduled on weekend day")
        end
      end

      context "hour out of range" do
        let(:start_time) { DateTime.now.next_week.change(hour: Appointment::DEFAULT_END_TIME) }

        it "returns array with errors" do
          expect(subject.call)
            .to include("Meeting time has to be set between #{Appointment::DEFAULT_START_TIME} and #{Appointment::DEFAULT_END_TIME}")
        end
      end
    end
  end
end
