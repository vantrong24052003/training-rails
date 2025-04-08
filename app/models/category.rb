class Category < ApplicationRecord
  # Associations
  has_many :posts, dependent: :nullify

  # Validations
  validates :name, presence: true, uniqueness: true
end
