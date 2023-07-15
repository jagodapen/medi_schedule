require 'rails_helper'

RSpec.describe Appointments::Data::DoctorsAvailableTimeSlots do
  describe ".for_next_week" do
    subject { described_class.new(doctor_id: doctor.id, start_day: slot.to_date) }

    let(:doctor) { create :doctor }
    let(:slot) { Date.today.to_datetime.in_time_zone("Europe/Warsaw").next_week.change(hour: 8, min: 0) }
    let!(:appointments) do
      [
        create(:appointment, doctor: doctor, start_time: slot),
        create(:appointment, doctor: doctor, start_time: (slot + 1.day)),
        create(:appointment, doctor: doctor, start_time: (slot + 2.days)),
      ]
    end

    it "returns hash" do
      time_slots_with_availability = subject.for_next_week.values.reduce({}, :merge)

      expect(subject.for_next_week).to be_a Hash
      expect(subject.for_next_week.first[1]).to be_a Hash
      expect(time_slots_with_availability).to include({slot=>false})
      expect(time_slots_with_availability).to include({(slot + 1.day)=>false})
      expect(time_slots_with_availability).to include({(slot + 2.days)=>false})
    end
  end
end
