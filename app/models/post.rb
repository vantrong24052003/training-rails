class Post < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy

  # Scopes
  scope :published, -> { where(published: true) }
  scope :recent, -> { order(created_at: :desc) }

  # Validations
  validates :title, presence: true, length: { minimum: 5, maximum: 100 }
  validates :content, presence: true
  validates :category_id, presence: true
end
