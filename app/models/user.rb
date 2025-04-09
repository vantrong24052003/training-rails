class User < ApplicationRecord
  after_create :send_welcome_email
  rolify
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable

  has_many :posts, dependent: :destroy
  has_many :comments, dependent: :destroy

  validates :email, presence: true, uniqueness: true,
           format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }

private

  def send_welcome_email
    begin
      # Đây là class mailer bạn đã tạo, kế thừa từ ApplicationMailer. Nó thường nằm ở file: app/mailers/user_mailer.rb
      UserMailer.with(user: self).welcome_email.deliver_later # Bắt đầu từ đây, user là user mới ( register thành công) truyền qua bên class UserMailler
    rescue => e
       Rails.logger.error "Failed to send welcome email: #{e.message}"
    end
  end
end
