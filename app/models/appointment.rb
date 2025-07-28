class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient

  validates :status, inclusion: { in: %w[open closed] }
  validates :recommendation, presence: true, if: :closed?

  validate :doctor_availability, on: :create

  enum :status, { open: "open", closed: "closed" }
  
  scope :recent, -> { order(created_at: :desc) }

  private

  def doctor_availability
    return unless doctor && status == 'open'
    unless doctor.can_accept_new_appointment?
      errors.add(:base, 'Лікар вже має максимальну кількість відкритих записів (10)')
    end
  end
end
