MyApp.get "/"  do
	erb :"/home"
end

MyApp.get "/addsong" do
	erb :"/add_song"
end

MyApp.post "/addsong" do
	newsong = Song.new(params[:songtitle],params[:artist],params[:album],params[:genre],params[:rating],params[:length])
	newsong.save

	erb :"/home"
end

MyApp.get "/songs" do
	@songs = Song.all
	erb :"/songs"
end

