require_relative '../config/database'
require_relative '../app/models/article'

puts "Seeding database..."

Article.create(title: 'Title ABC', content: 'Lorem Ipsum')
Article.create(title: 'Title ZFX', content: 'Some Blog Post')
Article.create(title: 'Title YNN', content: 'O_O_Y_O_O')

puts "Seeding complete! Article count: #{Article.count}"