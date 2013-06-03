require "sinatra"
require "sinatra/reloader"
require "movies"
require "image_suckr"
require "stock_quote"



get "/" do 
	erb :home
end

get "/image_result" do 
	@image_search = params[:image_search]
  begin
    suckr = ImageSuckr::GoogleSuckr.new

    @image_result = suckr.get_image_url({"q" => "#{@image_search}"})

    erb :image_result
  rescue
    erb :error
  end
end

get "/random_image" do
  random_choices = ["dinosaur", "pokemon", "moogle", "dragon quest slime", "teddy bear", 
    "ice cream", "magi-nation weebo", "strawberry", "book", "tulip", "cute robot", "glacier", "ayer's rock", 
    "paradise falls", "audrey hepburn", "rock climbing", "bowtie", "farm", "corgies", 
    "big sur"]
  @random_image = random_choices[rand(19)]
  suckr = ImageSuckr::GoogleSuckr.new

  @random_result = suckr.get_image_url({"q" => "#{@random_image}"})

  erb :random_image
end

get "/images" do 
	erb :images
end

get "/stock_result" do 
  @stock_search = params[:stock_search]
  begin
    @stock_result = StockQuote::Stock.quote(@stock_search)
    erb :stock_result
  rescue 
    erb :error
  end

  
end

get "/stocks" do
	erb :stocks
end

get "/movie_result" do
  @movie_search = params[:movie_search]
  begin
    @movie_result=Movies.find_by_title(@movie_search)
    suckr = ImageSuckr::GoogleSuckr.new
 
    @movie_image = suckr.get_image_url({"q" => "#{@movie_search}"})


    erb :movie_result
  rescue
    erb :error
  end
end

get "/movies" do
  erb :movies 
end