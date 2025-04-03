# db/seeds.rb
# Tạo users
admin = User.create!(name: 'Admin', email: 'admin@example.com', password: 'password')
john = User.create!(name: 'John Doe', email: 'john@example.com', password: 'password')

# Tạo categories
tech = Category.create!(name: 'Technology', description: 'Tech related posts')
travel = Category.create!(name: 'Travel', description: 'Travel experiences')

# Tạo posts
post1 = Post.create!(
title: 'Getting Started with Rails',
content: 'Rails is a web application framework...',
published: true,
user: admin,
category: tech
)

post2 = Post.create!(
title: 'My Trip to Japan',
content: 'Japan is an amazing country...',
published: true,
user: john,
category: travel
)

# Tạo comments
Comment.create!(content: 'Great post!', user: john, post: post1)
Comment.create!(content: 'Thanks for sharing', user: admin, post: post2)
