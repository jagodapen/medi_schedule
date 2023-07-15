require 'rails_helper'

RSpec.describe Appointments::Data::TimeSlots do
  describe ".find_for" do
    subject { described_class.new(day: day, start_hour: 8, end_hour: 10) }
    let(:day) { DateTime.now.next_week }
    let(:expected_result) do
      [
        day.to_datetime.in_time_zone("Europe/Warsaw").change(hour: 8, min: 0),
        day.to_datetime.in_time_zone("Europe/Warsaw").change(hour: 8, min: 30),
        day.to_datetime.in_time_zone("Europe/Warsaw").change(hour: 9, min: 0),
        day.to_datetime.in_time_zone("Europe/Warsaw").change(hour: 9, min: 30),
      ]
    end
    
    it "returns valid time_slots array" do
      expect(subject.find_for(minutes: 30)).to eq(expected_result)
    end
  end
end
