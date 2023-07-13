class PatientsController < ApplicationController
  def index
    @q = Patient.ransack(params[:q])
    @pagy, @patients = pagy(@q.result)
  end

  def appointments
    @q = Appointment.ransack(params[:q])
    @pagy, @appointments = pagy(@q.result.includes(:doctor, :patient).where(patient_id: params[:id]))
  end
end
