# db/seeds.rb
# Tạo users
admin = User.create!(email: 'admin@gmail.com', password: 'Admin123@')
john = User.create!(email: 'user@gmail.com', password: 'Admin123@')


# Gán roles cho users
admin.add_role(:admin) unless admin.has_role?(:admin)
john.add_role(:user) unless john.has_role?(:user)

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

puts "Seed data created successfully!"
puts "Created #{User.count} users"
puts "Created #{Role.count} roles"
puts "Created #{Category.count} categories"
puts "Created #{Post.count} posts"
puts "Created #{Comment.count} comments"
