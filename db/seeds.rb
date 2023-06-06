# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

User.destroy_all
Article.destroy_all
Comment.destroy_all

User.create!(email: 'test@test.fr', password: 'foobar')
Article.create!(
  title: 'Test',
  content: 'Test',
  user: User.last,
  is_private: true
)

users = []
comments = []
articles = []

5.times do
  user = User.create!(email: Faker::Internet.email, password: 'foobar')
  users << user
end

puts '5 users created'

10.times do
  article = Article.create!(
    title: Faker::Quote.robin,
    content: Faker::Quote.matz,
    user: users.sample,
    is_private: [true, false].sample
  )
  articles << article
end

puts '10 articles created'

50.times do
  comment = Comment.create!(content: Faker::Lorem.sentence, user: users.sample, article: articles.sample)
  comments << comment
end

puts '50 comments created'
