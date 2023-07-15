require 'rails_helper'

RSpec.describe Appointments::Validators::Date do
  describe ".call" do
    subject { described_class.new(day: start_time) }
    
    context "valid appointment date" do
      let(:start_time) { DateTime.now.next_week.change(hour: Appointment::DEFAULT_START_TIME) }

      it "returns true" do
        expect(subject.call).to be_truthy
      end
    end

    context "invalid appointment date" do
      context "date in past" do
        let(:start_time) { DateTime.now.change(hour: Appointment::DEFAULT_START_TIME).last_weekday }

        it "raises error" do
          expect { subject.call }.to raise_error(Appointments::Validators::Date::InvalidDate)
        end
      end

      context "weekend day" do
        let(:start_time) { DateTime.now.change(hour: Appointment::DEFAULT_START_TIME).beginning_of_week + 6.days }

        it "raises error" do
          expect { subject.call }.to raise_error(Appointments::Validators::Date::InvalidDate)
        end
      end

      context "hour out of range" do
        let(:start_time) { DateTime.now.next_week.change(hour: Appointment::DEFAULT_END_TIME) }

        it "raises error" do
          expect { subject.call }.to raise_error(Appointments::Validators::Date::InvalidDate)
        end
      end
    end
  end
end
