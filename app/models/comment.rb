class Comment < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :post

  # Broadcasting for real-time updates
  # Broadcast to a stream specific to the post this comment belongs to
  after_create_commit -> { broadcast_prepend_to [post, "comments"], partial: "comments/comment", locals: { comment: self } }
  after_update_commit -> { broadcast_replace_to [post, "comments"], partial: "comments/comment", locals: { comment: self } }
  after_destroy_commit -> { broadcast_remove_to [post, "comments"] }

  # Validations
  validates :content, presence: { message: "nội dung không được để trống" }

  scope :recent, -> { order(created_at: :desc) }
end
