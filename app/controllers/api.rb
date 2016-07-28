require 'json'

MyApp.get "/api/songs" do
	@arraytosearch = arrayToSearch()

	return @arraytosearch.to_json
end

MyApp.get "/api/artists" do
	arraytosearch = arrayToSearch()
	@artistarray = returnArtists(arraytosearch)

	return @artistarray.to_json
end

MyApp.get "/api/albums" do
	arraytosearch = arrayToSearch()
	@albumarray = returnAlbums(arraytosearch)

	return @albumarray.to_json
end