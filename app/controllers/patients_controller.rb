class PatientsController < ApplicationController
  def index
    @pagy, @patients = pagy(Patient.all)
  end
end
