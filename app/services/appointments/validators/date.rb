module Appointments
  module Validators
    class Date
      InvalidDate = Class.new(StandardError)

      def initialize(day:, start_hour: Appointment::DEFAULT_START_TIME, end_hour: Appointment::DEFAULT_END_TIME, duration: Appointment::DEFAULT_DURATION)
        @day = day.in_time_zone("Europe/Warsaw")
        @start_hour = start_hour.to_i
        @end_hour = end_hour.to_i
        @duration = duration.to_i
      end

      def call
        check_if_in_future
        check_if_week_day
        check_if_valid_hour
      end

      private

      def check_if_in_future
        return true if @day.future?

        raise InvalidDate, "Select future date"
      end

      def check_if_week_day
        return true if @day.on_weekday?

        raise InvalidDate, "Meeting can't be scheduled on weekend day"
      end

      def check_if_valid_hour
        return true if @day.between?(available_start_hour, available_end_hour)

        raise InvalidDate, "Meeting time has to be set between #{@start_hour} and #{@end_hour}"
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
    