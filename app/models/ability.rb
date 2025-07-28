class Ability
  include CanCan::Ability

  def initialize(user)
    return unless user

    if user.is_a?(AdminUser)
      admin_abilities
    elsif user.is_a?(Doctor)
      doctor_abilities(user)
    elsif user.is_a?(Patient)
      patient_abilities(user)
    end
  end

  private

  def admin_abilities
    can :manage, :all
  end

  def doctor_abilities(doctor)
    can :read, Doctor
    can [:update, :update_photo], Doctor, id: doctor.id
    can :read, Appointment, doctor_id: doctor.id
    can :update, Appointment, doctor_id: doctor.id
    can :read, Patient do |patient|
      Appointment.exists?(doctor_id: doctor.id, patient_id: patient.id)
    end
  end

  def patient_abilities(patient)
    can :read, Doctor
    can :read, Category
    can :create, Appointment
    can :read, Appointment, patient_id: patient.id
    can [:read, :update, :update_photo], Patient, id: patient.id
  end
end
