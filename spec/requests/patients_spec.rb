require 'rails_helper'

RSpec.describe "Patients", type: :request do
  describe "GET /index" do
    it "returns http success" do
      get "/patients"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /patients/:id/appointments" do
    let(:patient) { create :patient }

    it "returns http success" do
      get "/patients/#{patient.id}/appointments"
      expect(response).to have_http_status(:success)
    end
  end

  describe "GET /birth_date_statistics" do
    it "returns http success" do
      get "/patients/birth_date_statistics"
      expect(response).to have_http_status(:success)
    end
  end
end
