class AddConfirmableToUsers < ActiveRecord::Migration[6.1]
  def change
    add_column :users, :confirmation_token, :string # Token để xác thực (link trong email)
    add_column :users, :confirmed_at, :datetime #	Thời gian user đã xác thực
    add_column :users, :confirmation_sent_at, :datetime # Thời gian Devise gửi mail xác thực
    add_column :users, :unconfirmed_email, :string # 	Email mới (nếu user đổi email)
    add_index  :users, :confirmation_token, unique: true
  end
end
