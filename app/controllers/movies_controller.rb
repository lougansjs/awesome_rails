class MoviesController < ApplicationController
  before_action :set_movie, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  def index
      
    @search = Movie.reverse_chronologically.ransack(params[:q])

    respond_to do |format|
      format.any(:html, :json) { @movies = set_page_and_extract_portion_from @search.result }
      format.csv { render csv: @search.result }
    end
  end

  def show
    fresh_when etag: @movie
  end

  def new
    @movie = Movie.new
    @genre = Movie::GENRE
    @users = User.all.map(&:full_name)
  end

  def edit
    @genre = Movie::GENRE
    @users = User.all.map(&:full_name)
  end

  def create
    @movie = Movie.new(movie_params)
    @movie.save!

    respond_to do |format|
      format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
      format.json { render :show, status: :created }
    end
  end

  def update
    @movie.update!(movie_params)
    respond_to do |format|
      format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
      format.json { render :show }
    end
  end

  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url, notice: 'Movie was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def get_template
    template = params[:id].to_i

    if template == 1 || template == 2
      render file: "#{Rails.root}/app/assets/templates/index#{template}.html", layout: false
    else
      flash.alert = "Template inválido"
    end
  end

  def export
    movies = Movies.all

    if movies.present?
      render(text: movies, filename: 'movies.xlsx')
    else
      flash.alert = "Não há registros"
      redirect_to params[:path]
    end
  end

  def generate_tempfile
    name = params[:name]
    tempfile = Tempfile.new([name, '.pdf'], Rails.root.join('tmp'))
    tempfile.binmode
    tempfile.write(pdf_file)
    tempfile.close
  end

  def bad_send
    method = params[:method]
    @result = Movie.send(method.to_sym)
  end

  private


  def set_movie
    @movie = Movie.where("id = '#{params[:id]}'")
  end

  def movie_params
    params.require(:movie).permit!

  end


end
# Name: bootstrap-sass
# Version: 3.3.6