require 'rails_helper'

RSpec.describe Appointment, type: :model do
  subject { create :appointment }

  it { should belong_to(:doctor) }
  it { should belong_to(:patient) }

  it do 
    should validate_uniqueness_of(:start_time)
      .scoped_to(:doctor_id)
      .with_message("Doctor already has an appointment at this time")
  end
  
  it do
    should validate_uniqueness_of(:start_time)
      .scoped_to(:patient_id)
      .with_message("Patient already has an appointment at this time")
  end

  it { should validate_presence_of :doctor_id }
  it { should validate_presence_of :patient_id }
  
  describe ".incoming" do
    let(:incoming_date) { Date.today.to_datetime.in_time_zone("Europe/Warsaw").next_week.change(hour: 8, min: 0) }
    let(:incoming_appointment) { create :appointment, start_time: incoming_date }
    let(:past_date) { Date.yesterday.to_datetime.in_time_zone("Europe/Warsaw").change(hour: 8, min: 0) }
    let(:past_appointment) { create :appointment, :skip_validation, start_time: past_date }

    it "includes incoming appointments" do
      expect(Appointment.incoming).to include(incoming_appointment)
    end

    it "not includes past appointments" do
      expect(Appointment.incoming).not_to include(past_appointment)
    end
  end

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
