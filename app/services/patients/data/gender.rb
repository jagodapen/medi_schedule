module Patients
  module Data
    class Gender
      class << self
        def find(pesel:)
          return "male" if pesel[9].to_i % 2 == 1

          "female"
        end
      end
    end
  end
end
