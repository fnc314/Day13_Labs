class MoviesController < ApplicationController

  # route: GET    /movies(.:format)
  def index
    @movies = Movie.all
  end
  # route: # GET    /movies/:id(.:format)
  def show
    @movie = Movie.find_by(imdbid: params[:id])
  end

  # route: GET    /movies/new(.:format)
  def new
  end

  # route: GET    /movies/:id/edit(.:format)
  # def edit
  #   @movie = get_movie(params[:imdbid])
  # end

  #route: # POST   /movies(.:format)
  def create

    request = Typhoeus.get("www.omdbapi.com", :params => {t: params["movie"]["title"], y: params["movie"]["year"]})
    
    movie1 = JSON.parse(request.body)

    params[:movie][:imdbid] = movie1["imdbID"]

    movie2 = params[:movie].permit(:title, :year, :imdbid)
    # create new movie object from params

    # add object to movie db
    new_movie = Movie.create(movie2)
    # show movie page
    # render :index
    redirect_to action: :index
  end

  # route: PATCH  /movies/:id(.:format)
  # def update
  #   movie = get_movie(params[:id])
  #   updated_info = params[:movie].permit(:name, :year)
  #   movie.update_attributes(updated_info)
  #   redirect_to action: :show
  #   #implement
  # end

  # route: DELETE /movies/:id(.:format)
  def destroy
    movie = Movie.find_by(imdbid: params[:id])
    movie.destroy
    redirect_to action: :index
  end

  private

  # def get_movie(imdbid)
  #   the_movie = Movie.find_by(imdbid)
  #   if the_movie.nil?
  #     flash.now[:message] = "Movie not found"
  #     the_movie = {}
  #   end
  #   the_movie
  # end

end
