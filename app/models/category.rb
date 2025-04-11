class Category < ApplicationRecord
  # Associations
  has_many :posts, dependent: :nullify

  # Validations
 validates :name, presence: { message: "name category không được để trống" },
                 uniqueness: { message: "name category đã được sử dụng" }
end
