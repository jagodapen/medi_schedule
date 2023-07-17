module Patients
  module Validators
    class Pesel
      InvalidPesel = Class.new(StandardError)
      IncrediblyOld = Class.new(StandardError)

      def initialize(pesel:)
        pesel = pesel.to_s

        @month_first_digit = pesel[2].to_i
        @month_second_digit = pesel[3].to_i
        @day_first_digit = pesel[4].to_i
        @day_second_digit = pesel[5].to_i

        @errors = []
      end

      def call
        @errors.push("No way! Too old") if born_in_19th_century
        @errors.push("Pesel does not match expected format") if invalid_pesel
        
        return @errors
      end

      private

      def invalid_pesel
        @month_first_digit.in?([4, 5, 6, 7]) ||
        @day_first_digit > 3 ||
        (@day_first_digit == 3 && @day_second_digit > 1) ||
        (@month_first_digit.in?([0, 2]) && @month_second_digit == 2 && @day_first_digit > 2) ||
        (@month_first_digit.in?([1, 3]) && @month_second_digit > 2)
      end

      def born_in_19th_century
        @month_first_digit.in?([8, 9])
      end
    end
  end
end
