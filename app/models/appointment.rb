class Appointment < ApplicationRecord
  belongs_to :doctor
  belongs_to :patient

  validates :status, inclusion: { in: %w[open closed] }

  before_validation :set_default_status, on: :create

  enum status: { open: "open", closed: "closed" }


  def set_default_status
    self.status ||= 'open'
  end

  def close!(recommendation_text)
    update(status: 'closed', recommendation: recommendation_text)
  end
end
