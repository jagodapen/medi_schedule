module Appointments
  module Data
    class TimeSlots
      def initialize(day:, start_hour: Appointment::DEFAULT_START_TIME, end_hour: Appointment::DEFAULT_END_TIME)
        @day = day.to_date
        @start_hour = start_hour
        @end_hour = end_hour
      end

      def find_for(minutes:)
        calculate_time_slots(minutes: minutes)
        @day_time_slots
      end

      private

      def calculate_time_slots(minutes:)
        start_time = @day.to_datetime.in_time_zone("Europe/Warsaw").change(hour: @start_hour, min: 0)
        end_time = @day.to_datetime.in_time_zone("Europe/Warsaw").change(hour: @end_hour, min: 0) - minutes.minutes

        @day_time_slots = []

        (start_time.to_i..end_time.to_i).step(minutes.minutes) do |time_slot|
          @day_time_slots << Time.at(time_slot)
        end
      end
    end
  end
end
    