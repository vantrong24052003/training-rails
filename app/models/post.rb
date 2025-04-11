class Post < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :category
  has_many :comments, dependent: :destroy

  # Scopes
  scope :published, -> { where(published: true) }
  scope :recent, -> { order(created_at: :desc) }

  # Validations
   validates :title, presence: { message: "không được để trống" },
                    length: {
                      minimum: 5, maximum: 100,
                      too_short: "phải có ít nhất %{count} ký tự",
                      too_long: "không được vượt quá %{count} ký tự"
                    }

  validates :content, presence: { message: "không được để trống" }
  validates :category_id, presence: { message: "phải chọn một danh mục" }
end
