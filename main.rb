require "sinatra"
require "sinatra/reloader"
require "movies"
require "image_suckr"
require "stock_quote"


get "/" do
	erb :index
end

get "/stock" do
	erb :stock
end

get "/movie" do
  erb :movie
end

get "/image" do
	erb :image
end

get "/m_result" do
	movie_info = Movies.find_by_title(params[:film_name]) 
	@title = movie_info.title
	@director = movie_info.director
	@year = movie_info.year
	erb :m_result
end

get "/i_result" do
	@image = params[:image_name]
	suckr = ImageSuckr::GoogleSuckr.new 
	@photo = suckr.get_image_url({"q" => @image})  
	
	erb :i_result
end

get "/s_result" do
	begin
	stock = StockQuote::Stock.quote(params[:stock_sym])
	@quote = stock.last
	@symbol = stock.company
  rescue
  end
	erb :s_result
end
