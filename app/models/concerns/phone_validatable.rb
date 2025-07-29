module PhoneValidatable
  extend ActiveSupport::Concern

  included do
    before_validation :normalize_phone

    validates :phone, presence: true, uniqueness: true,
                      format: { with: /\A\+380\d{9}\z/, message: "має бути у форматі +380XXXXXXXXX" }
  end

  private

  def normalize_phone
    return if phone.blank?

    digits = phone.gsub(/\D/, '')
    if digits.length == 9
      self.phone = "+380#{digits}"
    elsif digits.match?(/\A380\d{9}\z/)
      self.phone = "+#{digits}"
    elsif digits.match?(/\A\+380\d{9}\z/)
      self.phone = digits
    else
      self.phone = nil
    end
  end
end
