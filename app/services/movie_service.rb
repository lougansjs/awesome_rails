# frozen_string_literal: true

# Este service e responsável por chamar a API de Filmes do TMDB
class MovieService
  def initialize(page = 1)
    @page = page
    @path = Rails.application.credentials[Rails.env.to_sym][:api_tmdb_url]
    @token = Rails.application.credentials[Rails.env.to_sym][:token_tmdb]
  end

  # Filmes mais votados
  def top_rated_movies
    url = "#{@path}/movie/top_rated?language=pt-BR"
    headers = { 'Authorization': @token }

    response = RestClient.get(url, headers)
    JSON.parse(response)
  end

  def most_popular_movies
    url = "#{@path}/movie/popular?language=pt-BR"
    headers = { 'Authorization': @token }

    response = RestClient.get(url, headers)
    JSON.parse(response)
  end
end
