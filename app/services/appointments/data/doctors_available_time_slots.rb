module Appointments
  module Data
    class DoctorsAvailableTimeSlots
      def initialize(doctor_id:, start_day: Date.today)
        @doctor_id = doctor_id
        @start_day = start_day
      end

      def for_next_week
        return [] unless @doctor_id

        week_time_slots.each_with_object({}) do |day_slots, big_hash|
          big_hash[day_slots[0]] = day_slots[1].each_with_object({}) do |slot, hash|
            hash[slot] = !slot.in?(doctors_week_appointments)
          end
        end
      end

      private

      def doctors_week_appointments
        @doctors_week_appointments ||= Appointment.where(
          doctor_id: @doctor_id,
          start_time: week.first.beginning_of_day..(week.last.end_of_day),
        ).map { |appointment| appointment.start_time }
      end

      def week_time_slots
        @week_time_slots = week.each_with_object({}) do |day, obj|
          obj[day.to_date] = Appointments::Data::TimeSlots.new(day: day.to_date).find_for(minutes: 20)
        end
      end

      def week
        (@start_day...(@start_day + 7.days))
      end
    end
  end
end
