module Patients
  module Data
    class Gender
      class << self
        # Assume the pesel is valid, to validate pesel call Patients::Validators::Pesel service
        def find(pesel:)
          return nil unless pesel
          return "male" if pesel[9].to_i % 2 == 1

          "female"
        end
      end
    end
  end
end
