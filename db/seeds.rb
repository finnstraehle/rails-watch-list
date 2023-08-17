require 'open-uri'
require 'json'
require 'faker'

url = 'http://tmdb.lewagon.com/movie/top_rated'
response = URI.open(url).read
movies = JSON.parse(response)['results']

# destroy all data
puts 'destroying data...'
Bookmark.destroy_all
List.destroy_all
Movie.destroy_all

# create movies
puts 'creating movies...'
movies.each do |movie|
  Movie.create!(
    title: movie['title'],
    overview: movie['overview'],
    poster_url: movie['poster_path'],
    rating: movie['vote_average']
  )
end

# create lists
puts 'creating lists...'
List.create!(name: 'Drama')
List.create!(name: 'Comedy')
List.create!(name: 'Action')
List.create!(name: 'Thriller')
List.create!(name: 'Horror')
List.create!(name: 'Sci-Fi')
List.create!(name: 'Romance')
List.create!(name: 'Animation')
List.create!(name: 'Documentary')

# create bookmarks
puts 'creating bookmarks...'
Movie.all.each do |movie|
  List.all.each do |list|
    Bookmark.create!(
      comment: Faker::Lorem.paragraph(sentence_count: 2),
      movie: movie,
      list: list
    )
  end
end

puts 'finished!'
