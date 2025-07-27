class Category < ApplicationRecord
  has_many :doctors, dependent: :nullify
  validates :title, presence: true, uniqueness: true

  def self.ransackable_attributes(auth_object = nil)
    ["created_at", "id", "id_value", "title", "updated_at"]
  end
end
