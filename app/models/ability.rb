class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= Patient.new(role: 'guest')

    if user.is_a?(AdminUser)
      admin_abilities
    elsif user.is_a?(Doctor)
      doctor_abilities(user)
    elsif user.is_a?(Patient)
      patient_abilities(user)
    else
      guest_abilities
    end
  end

  private

  def admin_abilities
    can :manage, :all
  end

  def doctor_abilities(doctor)
    # Лікар може читати і редагувати свій профіль
    can [:read, :update], Doctor, id: doctor.id

    # Лікар може бачити свої записи
    can :read, Appointment, doctor_id: doctor.id

    # Лікар може оновлювати записи зі статусом "open"
    can :update, Appointment, doctor_id: doctor.id, status: 'open'

    # Лікар може створювати рекомендації — у вас це поле у Appointment,
    # тож лікар може оновлювати поле recommendation у своїх Appointment
    can :update, Appointment, doctor_id: doctor.id

    # Лікар може читати пацієнтів, які записані до нього
    can :read, Patient do |patient|
      Appointment.exists?(doctor_id: doctor.id, patient_id: patient.id)
    end
  end

  def patient_abilities(patient)
    can :read, Doctor
    can :read, Category

    can :create, Appointment
    can [:read], Appointment, patient_id: patient.id

    # Пацієнт може читати свої рекомендації (через поле recommendation в Appointment)
    can :read, Appointment, patient_id: patient.id

    can [:read, :update], Patient, id: patient.id
  end

  def guest_abilities
    # Права для гостей (незареєстрованих)
    can :read, Doctor
    can :read, Category
  end
end
