class PatientsController < ApplicationController
  def index
    @q = Patient.ransack(params[:q])
    @pagy, @patients = pagy(@q.result)
    @birth_date_statistics = Patient.group_by_year(:birth_date, format: "%Y").count
  end

  def appointments
    @q = Appointment.ransack(params[:q])
    @pagy, @appointments = pagy(@q.result.includes(:doctor, :patient).where(patient_id: params[:id]))
    @incoming = Appointment.incoming
  end

  def birth_date_statistics
    @birth_date_statistics = Patient.group_by_year(:birth_date, format: "%Y").count
  end
end
