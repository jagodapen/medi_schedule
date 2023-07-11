class PatientsController < ApplicationController
  def index
    @q = Patient.ransack(params[:q])
    @pagy, @patients = pagy(@q.result)
  end
end
