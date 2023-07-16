require 'rails_helper'

RSpec.describe "Appointments", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/appointments"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /patients/:id/appointments/new" do
    let(:patient) { create :patient }

    it "returns http success" do
      get "/patients/#{patient.id}/appointments/new"
      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    let(:doctor) { create :doctor }
    let(:patient) { create :patient }
    let(:params) do
      {
        appointment: {
          doctor_id: doctor.id,
          patient_id: patient.id,
        },
        start_time: start_time,
        cost: 100,
        currency: Appointment::DEFAULT_CURRENCY,
        duration: Appointment::DEFAULT_DURATION,
      }
    end

    context "valid params" do
      let(:start_time) { Date.today.to_datetime.in_time_zone("Europe/Warsaw").next_week.change(hour: 8, min: 0) }
      
      it "returns http success" do
        post "/appointments", params: params
        expect(flash[:notice]).to eq("Appointment was successfully created.")
        expect(response).to redirect_to(appointments_patient_path(patient))
      end
    end

    context "invalid params" do
      let(:start_time) { Date.yesterday.to_datetime.in_time_zone("Europe/Warsaw").change(hour: 8, min: 0) }
      
      it "returns http unprocessable_entity" do
        post "/appointments", params: params
        expect(response).to have_http_status(:unprocessable_entity)
      end
    end
  end

  describe "DELETE /destroy" do
    let(:appointment) { create :appointment }

    it "returns http success" do
      delete "/appointments/#{appointment.id}"
      expect(response).to redirect_to(appointments_path)
    end
  end

  describe "GET /doctor_time_slots" do
    let(:doctor) { create :doctor }

    it "returns http success" do
      get "/appointments/doctor_time_slots?doctor_id=#{doctor.id}", as: :turbo_stream
      expect(response.media_type).to eq Mime[:turbo_stream]
    end
  end
end
