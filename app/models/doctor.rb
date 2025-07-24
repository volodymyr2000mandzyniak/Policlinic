# class Doctor < ApplicationRecord
#   # Include default devise modules. Others available are:
#   # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
#   devise :database_authenticatable, :registerable,
#         :recoverable, :rememberable, :validatable, authentication_keys: [ :phone ]

#   belongs_to :category

#   validates :phone, presence: true, uniqueness: true

#   def email_required?; false; end
#   def email_changed?; false; end

#   def self.ransackable_associations(auth_object = nil)
#     [ "category" ]
#   end

#   def self.ransackable_attributes(auth_object = nil)
#     [ "address", "category_id", "created_at", "date_of_birth", "email", "encrypted_password", "first_name", "id", "id_value", "last_name", "phone", "remember_created_at", "reset_password_sent_at", "reset_password_token", "updated_at" ]
#   end

#   def full_name
#     [ first_name, last_name ].compact.join(" ")
#   end

#   scope :approved, -> { where(approved: true) }

#   def approved?
#     approved == true
#   end

#   def self.ransackable_attributes(auth_object = nil)
#     super + ["approved"]
#   end
# end


class Doctor < ApplicationRecord
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable, authentication_keys: [:phone]

  belongs_to :category
  has_many :appointments
  has_many :patients, through: :appointments

  validates :phone, presence: true, uniqueness: true

  # Максимум 10 відкритих записів
  def can_accept_new_appointment?
    appointments.where(status: 'open').count < 10
  end

  scope :approved, -> { where(approved: true) }

  def approved?
    approved == true
  end

  def full_name
    "#{first_name} #{last_name}".strip
  end

  def email_required?; false; end
  def email_changed?; false; end

  def self.ransackable_associations(_auth_object = nil)
    ["category"]
  end

  def self.ransackable_attributes(_auth_object = nil)
    super + %w[
      address category_id created_at date_of_birth email
      encrypted_password first_name id last_name phone
      remember_created_at reset_password_sent_at reset_password_token
      updated_at approved
    ]
  end
end
