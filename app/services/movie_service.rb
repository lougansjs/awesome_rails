# frozen_string_literal: true

# Este service é responsável por chamar a API de Filmes do TMDB
class MovieService
  def top_rated_movies
    url = 'https://api.themoviedb.org/3/movie/top_rated?language=pt-BR'
    headers = { 'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJjNjk4MDI2NTc0ODlkZWQwYjU5ZTM4MTA0ZGE3YzhiMSIsInN1YiI6IjYxNDc4M2NlZTU1OTM3MDA0MzE5NjgyMSIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.8eoAD1p0UU_3MPGQI4wjfFjTZHYwgX0R8HmYU3URKHI' }
    RestClient.get(url, headers)
  end
end
