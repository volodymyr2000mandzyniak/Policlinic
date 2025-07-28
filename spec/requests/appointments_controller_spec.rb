require 'rails_helper'

RSpec.describe AppointmentsController, type: :controller do
let(:doctor) { create(:doctor, approved: true) }
  let(:patient) { create(:patient) }
  let(:valid_attributes) { { doctor_id: doctor.id } }

  before do
    allow(controller).to receive(:current_patient).and_return(nil)
    allow(controller).to receive(:current_doctor).and_return(nil)
  end

  describe "POST #create" do
    context "when patient is logged in" do
      before { allow(controller).to receive(:current_patient).and_return(patient) }

      context "with approved doctor" do
        it "creates appointment and redirects" do
          expect {
            post :create, params: { appointment: valid_attributes }
          }.to change(Appointment, :count).by(1)

          expect(response).to redirect_to(doctor_path(doctor))
          expect(flash[:notice]).to eq("Запис успішно створено!")
        end
      end

      context "with invalid doctor" do
        it "does not create appointment and redirects with alert" do
          post :create, params: { appointment: { doctor_id: -1 } }

          expect(response).to redirect_to(root_path)
          expect(flash[:alert]).to eq("Обраного лікаря не існує або він неактивний")
        end
      end
    end
  end

  describe "GET #index" do
    context "as doctor" do
      let(:doctor) { create(:doctor) }
      before do
        allow(controller).to receive(:current_doctor).and_return(doctor)
      end

      it "assigns doctor's appointments" do
        appointment = create(:appointment, doctor: doctor)
        get :index
        expect(assigns(:appointments)).to include(appointment)
      end
    end

    context "as patient" do
      before { allow(controller).to receive(:current_patient).and_return(patient) }

      it "assigns patient's appointments" do
        appointment = create(:appointment, patient: patient)
        get :index
        expect(assigns(:appointments)).to include(appointment)
      end
    end

    context "unauthenticated" do
      it "redirects to root" do
        get :index
        expect(response).to redirect_to(root_path)
expect(flash[:alert]).to eq("You are not authorized to access this page.")
      end
    end
  end

  describe "PATCH #update" do
    let(:doctor) { create(:doctor) }
    let(:appointment) { create(:appointment, doctor: doctor) }

    before do
      allow(controller).to receive(:current_doctor).and_return(doctor)
      allow(controller).to receive(:authorize!).with(:update, anything).and_return(true)
    end

    it "updates appointment to closed and sets recommendation" do
      patch :update, params: { id: appointment.id, appointment: { recommendation: "Rest" } }
      appointment.reload

      expect(appointment.status).to eq("closed")
      expect(appointment.recommendation).to eq("Rest")
      expect(response).to redirect_to(appointments_path)
    end
  end

  describe "GET #closed" do
    let(:doctor) { create(:doctor) }

    before do
      allow(controller).to receive(:current_doctor).and_return(doctor)
      allow(controller).to receive(:authorize!).with(:read, Appointment).and_return(true)
    end

    it "assigns closed appointments" do
      closed_appointment = create(:closed_appointment, doctor: doctor)
      get :closed
      expect(assigns(:appointments)).to include(closed_appointment)
    end
  end

  describe "GET #my_open" do
    before do
      allow(controller).to receive(:current_patient).and_return(patient)
      allow(controller).to receive(:authorize!).with(:read, Appointment).and_return(true)
    end

    it "returns open appointments for current_patient" do
      open_appt = create(:appointment, patient: patient, status: "open")
      get :my_open
      expect(assigns(:appointments)).to include(open_appt)
    end
  end

  describe "GET #my_closed" do
    before do
      allow(controller).to receive(:current_patient).and_return(patient)
      allow(controller).to receive(:authorize!).with(:read, Appointment).and_return(true)
    end

    it "returns closed appointments for current_patient" do
      closed_appt = create(:closed_appointment, patient: patient)
      get :my_closed
      expect(assigns(:appointments)).to include(closed_appt)
    end
  end
end
