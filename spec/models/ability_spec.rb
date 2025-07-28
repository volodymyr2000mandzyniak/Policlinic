require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do
  let(:doctor) { create(:doctor) }
  let(:other_doctor) { create(:doctor) }
  let(:appointment) { create(:appointment, doctor: doctor) }
  let(:other_appointment) { create(:appointment) }
  let(:patient) { create(:patient) }

  subject(:ability) { Ability.new(doctor) }

  context "as doctor" do
    it { is_expected.to be_able_to(:read, Doctor) }
    it { is_expected.to be_able_to(:update, doctor) }
    it { is_expected.to be_able_to(:update_photo, doctor) }
    it { is_expected.not_to be_able_to(:update, other_doctor) }

    it { is_expected.to be_able_to(:read, appointment) }
    it { is_expected.not_to be_able_to(:read, other_appointment) }

    it "can read patient if appointment exists" do
      create(:appointment, doctor: doctor, patient: patient)
      expect(ability).to be_able_to(:read, patient)
    end

    it "cannot read unrelated patient" do
      expect(ability).not_to be_able_to(:read, patient)
    end
  end
end
