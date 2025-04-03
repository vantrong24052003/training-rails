# app/models/user.rb
class User < ApplicationRecord
has_many :posts, dependent: :destroy
has_many :comments, dependent: :destroy

validates :name, presence: true
validates :email, presence: true, uniqueness: true,
                  format: { with: /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i }
has_secure_password
end
