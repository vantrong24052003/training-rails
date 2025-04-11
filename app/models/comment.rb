class Comment < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :post

  # Validations
  validates :content, presence: { message: "nội dung không được để trống" }

  scope :recent, -> { order(created_at: :desc) }
end
