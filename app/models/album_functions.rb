
# Function to obtain album data from last.fm API.
#
# artist, album - provides the artist name and ablum title from the songs table using query string parameters.
#
# Returns an HTTParty method used to make an album.getinfo request to the last.fm API.
def getAlbumInfo(artist,album)
  return HTTParty.get("http://ws.audioscrobbler.com/2.0/?method=album.getinfo&api_key=#{API_KEY}&artist=#{artist}&album=#{album}&format=json")
end


# Function is used to navigate to an album page on the last.fm website.
#
# albumdata - Variable contains a hash of data from the last.fm API for a specific album.
#
# Returns a string containing the URL for a specific album.
def getAlbumUrl(albumdata)
	if albumdata["error"] == 6
	else
		albumdata["album"]["url"]
	end
end


# Function is used to grab an album image.
#
# albumdata - Variable contains a hash of data from the last.fm API for a specific album.
#
# Returns a string containing the URL for the image of a specific album cover.
def getAlbumImage(albumdata)
	if albumdata["error"] == 6
	else
		albumdata["album"]["image"][3]["#text"]
	end
end


# Function provides a list of tracks for a specific album.
#
# albumdata - Variable contains a hash of data from the last.fm API for a specific album.
#
# Returns an array of strings (where each element represents a song name) for a specific album.
def getAlbumTracks(albumdata)
	if albumdata["error"] == 6
	else
		trackarray = albumdata["album"]["tracks"]["track"]
		b = []
		z = 0
		trackarray.each do |i|
			b.push(trackarray[z]["name"])
		    z=z+1
		end
	end
	return b
end



