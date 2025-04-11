✅ 1. Model

Thứ

Ví dụ

Ghi nhớ

Tên class model

class Post < ApplicationRecord

Singular, CamelCase

Tên file

post.rb

snake_case, số ít

Tên bảng DB

posts

Plural, snake_case (tự tạo bởi Rails từ model)

Table migration

create_table :posts

plural (giống tên bảng)

🔸 Rails tự map: Post ↔ bảng posts

✅ 2. Controller

Thứ

Ví dụ

Ghi nhớ

Tên class controller

PostsController

Plural + "Controller"

Tên file

posts_controller.rb

plural snake_case

Tên folder view

app/views/posts/

plural, khớp tên controller

🔸 Controller plural vì nó xử lý nhiều đối tượng.

✅ 3. Route

Thứ

Ví dụ

Ghi nhớ

resources

resources :posts

tạo toàn bộ route CRUD cho posts

Route name (prefix)

posts_path, new_post_path(@post)

auto-gen từ model

Controller mapping

posts#index, posts#show

action trong PostsController

🔸 Route thì plural, trừ khi bạn custom thủ công.

✅ 4. Views

Thứ

Ví dụ

Ghi nhớ

Folder

app/views/posts/

plural, theo controller

File

index.html.erb, show.html.erb

đặt theo action

✅ 5. Database Migration

Thứ

Ví dụ

Ghi nhớ

File

20250407123456_create_posts.rb

tự gen theo timestamp

Class

class CreatePosts < ActiveRecord::Migration

PascalCase, plural

Method

`create_table :posts do

t

... end`

plural, giống tên bảng model

🛠 Khi đặt sai tên thì sửa thế nào?

❌ Ví dụ sai:

bin/rails generate model Posts  # sai vì "Posts" là plural
bin/rails generate controller Post  # sai vì controller phải plural

✅ Cách sửa:

bin/rails destroy model Posts
bin/rails destroy controller Post

Nếu bạn đã chạy db:migrate thì rollback lại:

bin/rails db:rollback

🚀 Tổng hợp lệnh hay dùng nhất

# Tạo model + migration
bin/rails generate model Post title:string body:text

# Tạo controller với action
bin/rails generate controller Posts index show new edit

# Tạo resource route (chèn vào routes.rb)
resources :posts

# Tạo toàn bộ scaffold (model + controller + views + routes)
bin/rails generate scaffold Post title:string body:text

# Rollback migration nếu tạo sai
bin/rails db:rollback

# Destroy generator (model, controller...)
bin/rails destroy model Post

👉 Gợi ý: Luôn dùng singular cho model và plural cho mọi thứ còn lại (controller, table, folder, route).

✅ 6. Helpers

Thứ

Ví dụ

Ghi nhớ

File

posts_helper.rb

plural, snake_case như controller

Module

module PostsHelper

PascalCase, plural

Gọi trong view

link_to "Edit", edit_post_path(post)

helper auto từ route, model

✅ 7. Form Helpers (form_with)

<%= form_with model: @post, local: true do |form| %>
  <%= form.text_field :title %>
  <%= form.text_area :body %>
  <%= form.submit %>
<% end %>

Cần nhớ

Ghi chú

model:

dùng instance variable như @post (model phải singular)

Tên biến form

tuỳ chọn, phổ biến là form hoặc f

Các field như form.text_field

dùng tên thuộc tính của model (ví dụ: :title)

✅ 8. Associations

Quan hệ

Cú pháp trong Model

Migration tương ứng

1-n (User có nhiều Post)

has_many :posts trong Userbelongs_to :user trong Post

t.references :user, foreign_key: true trong posts

n-n (through)

has_many :tags, through: :taggings

Phải có bảng nối như taggings với 2 foreign_key

👉 Tên foreign key: snake_case_singular_id (ví dụ: user_id, post_id)

✅ 9. resource vs resources

Loại

Cú pháp

Đặc điểm

resource

resource :profile

Singular route (không có :id), dùng cho 1-1 quan hệ (ví dụ: user profile)

resources

resources :posts

Plural, tạo đầy đủ 7 RESTful routes cho collection

🔹 Dùng resource khi mỗi user chỉ có 1 đối tượng (như profile, account).
🔹 Dùng resources khi là danh sách nhiều item (như posts, comments).

👉 Bạn có thể tiếp tục bổ sung phần: Concerns, Nested Routes, Scopes, v.v. nếu cần chi tiết hơn nữa!
