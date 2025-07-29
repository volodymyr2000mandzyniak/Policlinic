class Patient < ApplicationRecord
  include PhoneValidatable

  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable, authentication_keys: [:phone]

  validates :phone, presence: true, uniqueness: true

  has_many :appointments, dependent: :nullify
  has_many :doctors, through: :appointments
  has_one_attached :photo



  def email_required?; false; end
  def email_changed?; false; end

  def full_name
    [first_name, last_name].compact.join(" ")
  end


  def self.ransackable_attributes(auth_object = nil)
    ["address", "created_at", "date_of_birth", "email", "encrypted_password", "first_name", "id", "id_value", "last_name", "phone", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at"]
  end
end
