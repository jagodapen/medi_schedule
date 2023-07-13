class AppointmentsController < ApplicationController
  protect_from_forgery with: :null_session

  def index
    @q = Appointment.ransack(params[:q])
    @pagy, @appointments = pagy(@q.result.includes(:doctor, :patient))
  end

  def show
    @appointment = Appointment.find(params[:id])
  end

  def new
    @appointment = Appointment.new(patient_id: params[:patient_id])
    @doctors = Doctor.all
    @time_slots = week_time_slots(Date.today)
  end

  def create
    @doctors = Doctor.all
    @appointment = Appointment.create(appointment_params)
    
    if @appointment.errors.empty?
      redirect_to appointments_url, notice: "Appointment was successfully created."
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
    doctor_id = params[:doctor_id]
    @time_slots = Appointments::Data::DoctorsAvailableTimeSlots.new(doctor_id: doctor_id).for_next_week
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

  def week_time_slots(start_day)
    @week_time_slots = (start_day...(start_day + 7.days)).each_with_object({}) do |day, obj|
      obj[day.to_date] = Appointments::Data::TimeSlots.new(day: day.to_date).find_for(minutes: 20)
    end
  end
end
