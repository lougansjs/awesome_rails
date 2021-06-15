class Movie < ApplicationRecord
  has_one_attached :image
  GENRE = [
    'Ação',
    'Aventura',
    'Cinema de arte',
    'Comédia',
    'Comédia de ação',
    'Comédia de terror',
    'Comédia dramática',
    'Comédia romântica',
    'Dança',
    'Documentário',
    'Docuficção',
    'Drama',
    'Espionagem',
    'Faroeste',
    'Fantasia',
    'Fantasia científica',
    'Ficção científica',
    'Filme com truques',
    'Filme de guerra',
    'Musical',
    'Filme policial',
    'Romance',
    'Seriado',
    'Suspense',
    'Terror',
    'Thriller'
  ]
end
