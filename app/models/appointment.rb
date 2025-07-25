class Appointment < ApplicationRecord
  belongs_to :doctor, optional: true
  belongs_to :patient, optional: true

  validates :status, inclusion: { in: %w[open closed] }
  validate :doctor_availability, on: :create

  enum status: { open: "open", closed: "closed" }

  private

  def doctor_availability
    return unless doctor && status == "open"

    unless doctor.can_accept_new_appointment?
      errors.add(:base, "Лікар вже має максимальну кількість відкритих записів (10)")
    end
  end
end
