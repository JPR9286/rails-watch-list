# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end
require 'open-uri'
require 'json'

# URL de l'API
url = 'https://tmdb.lewagon.com/movie/top_rated'

# Ouvrir l'URL et lire la réponse
response = URI.open(url).read

# Parser la réponse JSON
movies = JSON.parse(response)['results']

# Boucler sur les films et les créer dans la base de données
movies.each do |movie|
  # Ici, adaptez les champs selon votre modèle de Movie
  Movie.create(
    title: movie['title'],
    overview: movie['overview'],
    poster_url: "https://image.tmdb.org/t/p/w500#{movie['poster_path']}",
    rating: movie['vote_average']
  )
end

puts 'Movies created successfully!'
