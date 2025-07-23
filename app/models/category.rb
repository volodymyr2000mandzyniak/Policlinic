class Category < ApplicationRecord
  has_many :doctors, dependent: :nullify

  # validates :title, presence: true, uniqueness: true
end
