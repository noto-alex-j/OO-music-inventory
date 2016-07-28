
MyApp.get "/"  do
	erb :"/home"
end


MyApp.get "/songs" do
	x = createFileArray()

 	erb :"/songs", :locals => {'x' => x}
end

MyApp.post "/songs" do
	@search = params[:searchParam]
	@arraytosearch = arrayToSearch()

	searchresult = searchResult(@search,@arraytosearch)	

	erb :"/searchresults", :locals => {'searchresult' => searchresult}
end


MyApp.get "/albums" do
	arraytosearch = arrayToSearch()
	@albumarray = returnAlbums(arraytosearch)

	erb :"/albums"
end

MyApp.get "/albumdetail" do
	@album = params[:album]
	@artist = params[:artist]
	@albumdata = getAlbumInfo(@artist,@album)

	@album_url = getAlbumUrl(@albumdata)
	@album_img = getAlbumImage(@albumdata)
	@error_msg = "Album not found."

	@tracklist = getAlbumTracks(@albumdata)

	erb :"/albumdetail"
end


MyApp.get "/artists" do
	arraytosearch = arrayToSearch()
	@artistarray = returnArtists(arraytosearch)

	@artist = params[:artist]

	@topalbums = TopAlbum.new(params[:artist])
	@similarartists = Artist.new(params[:artist])
	@toptracks = TopTrack.new(params[:artist])

	
	erb :"/artists"
end


MyApp.get "/songsbyartist" do
	arraytosearch = arrayToSearch()
	@search = params[:artist]
	@arraytosearch = arrayToSearch()

	@searchresult = searchResult(@search,@arraytosearch)

	erb :"/songs_by_artist"
end


# ---- Controls for add forms below ----

MyApp.post "/add_song" do

	@titleParam = params[:titleParam]
	@artistParam = params[:artistParam]
	@albumParam = params[:albumParam]
	@genreParam = params[:genreParam]
	@minuteParam = params[:minuteParam]
	@secondParam = params[:secondParam]
	@rateSongParam = params[:rateSongParam]
	@rateAlbumParam = params[:rateAlbumParam]

	@song = Song.new(@titleParam,@artistParam,@albumParam,@genreParam,@minuteParam,@secondParam,@rateSongParam,@rateAlbumParam)
	
	songinfo = @song.songinfo
	
	# TODO - Figure out why != doesn't work.
	if songinfo == "||||||||||||||"
	else
		songAdd2File(songinfo)
	end

	x = createFileArray()

  	erb :"/songs", :locals => {'x' => x}

end

MyApp.get "/add_song" do

	createFileWithHeader

	erb :"add_forms/add_song"

end

# ---- Controls for delete forms below ----

MyApp.get "/delete" do
	erb :"/add_forms/delete_song"
end


MyApp.post "/delete" do
	@songdelete = params[:songdeleteParam]
  @artistdelete = params[:artistdeleteParam]
  @albumdelete = params[:albumdeleteParam]

  @delete = ""

  if @songdelete != ""
  	@delete = @songdelete
  elsif @artistdelete != ""
  	@delete = @artistdelete
  elsif @albumdelete != ""
  	@delete = @albumdelete
  end

  @arraytosearch = arrayToSearch()

  @allbutdeleted = allButDeleted(@delete,@arraytosearch)

  deleteResultToFile(@allbutdeleted)

 	x = createFileArray()
 	erb :"/songs", :locals => {'x' => x}

end





