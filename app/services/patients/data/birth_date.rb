module Patients
  module Data
    class BirthDate
      InvalidPesel = Class.new(StandardError)

      class << self
        def find(pesel:)
          @pesel = pesel

          year + "-#{month}-" + day
        rescue Date::Error => e
          raise InvalidPesel, "Pesel does not match expected format: #{e}"
        end

        private

        def century
          return "19" if @pesel[2].in?(%w(0 1))
          return "20" if @pesel[2].in?(%w(2 3))
          return "18" if @pesel[2].in?(%w(8 9))
        end

        def year
          century + @pesel.first(2)
        end

        def month
          month_in_pesel = @pesel.slice(2, 2)
          return month_in_pesel if century == "19"
          return (month_in_pesel.to_i - 20).to_s if century == "20"

          (month_in_pesel.to_i - 80).to_s
        end

        def day
          @pesel.slice(4, 2)
        end
      end
    end
  end
end
