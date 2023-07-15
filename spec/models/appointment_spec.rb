require 'rails_helper'

RSpec.describe Appointment, type: :model do
  subject { create :appointment }

  it { should belong_to(:doctor) }
  it { should belong_to(:patient) }

  it { should validate_uniqueness_of(:start_time).scoped_to(:doctor_id) }
  it { should validate_presence_of :doctor_id }
  it { should validate_presence_of :patient_id }

  describe "before_save validation" do
    context "valid appointment date" do
      let(:appointment) { build :appointment }

      it "saves appointment" do
        expect { appointment.save }.to change(Appointment, :count).by(1)
      end
    end
    context "invalid appointment date" do
      let(:appointment) { build :appointment, start_time: start_time }

      context "date in past" do
        let(:start_time) { DateTime.now.change(hour: Appointment::DEFAULT_START_TIME).last_weekday.in_time_zone("Europe/Warsaw") }

        it "do not save appointment" do
          expect { appointment.save }.not_to change(Appointment, :count)
        end
      end

      context "weekend day" do
        let(:start_time) { (DateTime.now.beginning_of_week + 6.days).in_time_zone("Europe/Warsaw").change(hour: Appointment::DEFAULT_START_TIME) }

        it "raises error" do
          expect { appointment.save }.not_to change(Appointment, :count)
        end
      end

      context "hour out of range" do
        let(:start_time) { DateTime.now.next_week.in_time_zone("Europe/Warsaw").change(hour: Appointment::DEFAULT_END_TIME) }

        it "raises error" do
          expect { appointment.save }.not_to change(Appointment, :count)
        end
      end
    end
  end
end
