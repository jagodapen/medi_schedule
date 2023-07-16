module Appointments
  module Validators
    class Date
      def initialize(day:, start_hour: Appointment::DEFAULT_START_TIME, end_hour: Appointment::DEFAULT_END_TIME, duration: Appointment::DEFAULT_DURATION)
        @day = day&.in_time_zone("Europe/Warsaw")
        @start_hour = start_hour.to_i
        @end_hour = end_hour.to_i
        @duration = duration.to_i

        @errors = []
      end

      def call
        if day_provided
          day_in_future
          week_day
          valid_hour
        end
        
        @errors
      end

      private

      def day_provided
        return true if @day

        @errors.push("Date not provided") and return false
      end

      def day_in_future
        return true if @day.future?

        @errors.push("Select future date")
      end

      def week_day
        return true if @day.on_weekday?

        @errors.push("Meeting can't be scheduled on weekend day")
      end

      def valid_hour
        return true if @day.between?(available_start_hour, available_end_hour)

        @errors.push("Meeting time has to be set between #{@start_hour} and #{@end_hour}")
      end

      def available_start_hour
        @day.change(hour: @start_hour)
      end

      def available_end_hour
        @day.change(hour: @end_hour) - @duration.minutes
      end
    end
  end
end
    