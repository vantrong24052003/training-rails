class Post < ApplicationRecord
belongs_to :user
belongs_to :category
has_many :comments, dependent: :destroy

validates :title, presence: true, length: { minimum: 5, maximum: 100 }
validates :content, presence: true

scope :published, -> { where(published: true) }
scope :recent, -> { order(created_at: :desc) }
end
