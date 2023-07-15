class AppointmentsController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    @q = Appointment.ransack(params[:q])
    @pagy, @appointments = pagy(@q.result.includes(:doctor, :patient))
    @incoming = Appointment.incoming
  end

  def new
    @appointment = Appointment.new(patient_id: params[:patient_id])
    @doctors = Doctor.all
    @time_slots = {}
  end

  def create
    @appointment = Appointment.create(appointment_params)
    @doctors = Doctor.all
    
    if @appointment.errors.empty?
      redirect_to  appointments_patient_url(params.dig(:appointment, :patient_id)), notice: "Appointment was successfully created."
    else
      render :new, status: :unprocessable_entity, alert: @appointment.errors.messages
    end
  end

  def destroy
    @appointment = Appointment.find(params[:id])
    @appointment.destroy
    redirect_to appointments_url, notice: "Appointment was successfully deleted."
  end

  def doctor_time_slots
    @time_slots = Appointments::Data::DoctorsAvailableTimeSlots
                    .new(doctor_id: params[:doctor_id])
                    .for_next_week
    @target = params[:target]

    respond_to do |format|
      format.turbo_stream
    end
  end

  private

  def appointment_params
    params
    .require(:appointment)
    .permit(:doctor_id, :patient_id, :start_time, :cost, :duration)
    .to_h
    .merge({ 
      start_time: params[:start_time].to_datetime.in_time_zone("Europe/Warsaw"),
      currency: Appointment::DEFAULT_CURRENCY,
      duration: Appointment::DEFAULT_DURATION,
    })
  end
end
