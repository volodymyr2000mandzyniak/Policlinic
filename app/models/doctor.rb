class Doctor < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
        :recoverable, :rememberable, :validatable, authentication_keys: [:phone]

  belongs_to :category

  validates :phone, presence: true, uniqueness: true

  # def email_required?
  #   false
  # end

  # def email_changed?
  #   false
  # end
  
  def email_required?; false; end
  def email_changed?; false; end


    def full_name
    [first_name, last_name].compact.join(' ')
  end
end
