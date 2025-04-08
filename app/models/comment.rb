class Comment < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :post

  # Validations
  validates :content, presence: true

  scope :recent, -> { order(created_at: :desc) }
end
