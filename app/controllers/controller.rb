MyApp.get "/"  do
	erb :"/home"
end

MyApp.get "/addsong" do
	erb :"/add_song"
end

MyApp.post "/addsong" do
	newsong = Song.new(params[:songtitle],params[:artist],params[:album],params[:genre],params[:rating],params[:length])
	newsong.save
	@songs = Song.all

	erb :"/songs"
end

MyApp.get "/songs" do
	@songs = Song.all

	erb :"/songs"
end

MyApp.post "/songs" do
	Song.delete(params[:delete])
	@songs = Song.all

	erb :"/songs"
end

MyApp.post "/search" do
	@search = Artist.findname(params[:search])

	erb :"/search"
end

MyApp.get "/artist/:artist" do
	@topalbums = TopAlbum.new(params[:artist]).getTopAlbumInfo
	@toptracks = TopTrack.new(params[:artist]).getTopTrackInfo
	@artist = ArtistInfo.new(params[:artist])
    @similar = @artist.getSimilarArtistInfo
    @artistinfo = @artist.getArtistInfo

	erb :"/artist"
end