# Functions for Top Albums section of Artists page
#
# Functions request 'top albums' array from Last.fm API 
#
# Functions obtain URLs, titles, and images from 'top albums' array and return them in separate arrays. 

class TopAlbum

	def initialize(artist)
		@topalbumsarray = HTTParty.get("http://ws.audioscrobbler.com/2.0/?method=artist.gettopalbums&artist=#{artist}&api_key=#{API_KEY}&format=json")
		@albumurls = Array.new
		@albumnames = Array.new
		@albumimages = Array.new
		self.topAlbumUrls()
		self.topAlbumNames()
		self.topAlbumImages()
	end
	
	def topAlbumUrls
		if @topalbumsarray["error"] != 6
			@topalbumsarray["topalbums"]["album"].each do |x|
				url = x["url"]
				@albumurls.push(url)
			end
		end
	end
	
	def topAlbumNames
		if @topalbumsarray["error"] != 6
			@topalbumsarray["topalbums"]["album"].each do |x|
				name = x["name"]
				@albumnames.push(name)
			end
		end
	end
	
	def topAlbumImages
		if @topalbumsarray["error"] != 6
			@topalbumsarray["topalbums"]["album"].each do |x|
				image = x["image"][2]["#text"]
				@albumimages.push(image)
			end
		end
	end

	def getTopAlbumInfo
		topAlbumInfo = [
			{"name" => @albumnames[0], "url" => @albumurls[0], "image" => @albumimages[0]},
			{"name" => @albumnames[1], "url" => @albumurls[1], "image" => @albumimages[1]},
			{"name" => @albumnames[2], "url" => @albumurls[2], "image" => @albumimages[2]}
		]
		return topAlbumInfo
	end


end

# Functions for Top Tracks section of Artists page
#
# Functions request 'top tracks' array from Last.fm API 
#
# Functions obtain URLs, titles, and images from 'top tracks' array and return them in separate arrays. 

class TopTrack

	def initialize(artist)
		@toptracksarray = HTTParty.get("http://ws.audioscrobbler.com/2.0/?method=artist.gettoptracks&artist=#{artist}&api_key=#{API_KEY}&format=json")
		@trackurls = Array.new
		@tracknames = Array.new
		@trackimages = Array.new
		self.topTrackUrls()
		self.topTrackNames()
		self.topTrackImages()
	end
	
	def topTrackUrls
		if @toptracksarray["error"] != 6
			@toptracksarray["toptracks"]["track"].each do |x|
				url = x["url"]
				@trackurls.push(url)
			end
		end
	end
	
	def topTrackNames
		if @toptracksarray["error"] != 6
			@toptracksarray["toptracks"]["track"].each do |x|
				name = x["name"]
				@tracknames.push(name)
			end
		end
	end
	
	def topTrackImages
		if @toptracksarray["error"] != 6
			@toptracksarray["toptracks"]["track"].each do |x|
				image = x["image"][2]["#text"]
				@trackimages.push(image)
			end
		end
	end

	def getTopTrackInfo
		topTrackInfo = [
			{"name" => @tracknames[0], "url" => @trackurls[0], "image" => @trackimages[0]},
			{"name" => @tracknames[1], "url" => @trackurls[1], "image" => @trackimages[1]},
			{"name" => @tracknames[2], "url" => @trackurls[2], "image" => @trackimages[2]}
		]
		return topTrackInfo
	end

end


# Functions for Artist Info section of Artists page
#
# Functions request 'artistinfo' array from Last.fm API 
#
# Functions obtain URLs, titles, and images from 'similar artists' array and return them in separate arrays. 

class ArtistInfo

	def initialize(artist)
		@artistinfo = HTTParty.get("http://ws.audioscrobbler.com/2.0/?method=artist.getinfo&artist=#{artist}&api_key=#{API_KEY}&format=json")
		@artistnames = Array.new
		@artisturls = Array.new
		@artistimages = Array.new
		@artistname = artist
		self.similarArtistUrls()
		self.similarArtistNames()
		self.similarArtistImages()
	end
	
	def similarArtistUrls
		if @artistinfo["error"] != 6
			@artistinfo["artist"]["similar"]["artist"].each do |x|
				url = x["url"]
				@artisturls.push(url)
			end
		end
	end
	
	def similarArtistNames
		 if @artistinfo["error"] != 6
		 	@artistinfo["artist"]["similar"]["artist"].each do |x|
				name = x["name"]
				@artistnames.push(name)
			end
		end
	end
	
	def similarArtistImages
		if @artistinfo["error"] != 6
			@artistinfo["artist"]["similar"]["artist"].each do |x|
				image = x["image"][2]["#text"]
				@artistimages.push(image)
			end
		end
	end

	def getSimilarArtistInfo
		similarArtistInfo = [
			{"name" => @artistnames[0], "url" => @artisturls[0], "image" => @artistimages[0]},
			{"name" => @artistnames[1], "url" => @artisturls[1], "image" => @artistimages[1]},
			{"name" => @artistnames[2], "url" => @artisturls[2], "image" => @artistimages[2]}
		]
		return @similarArtistInfo
	end

	def getArtistInfo
		if @artistinfo["error"] != 6
			artist = {
				"name" => @artistname,
				"url" => @artistinfo["artist"]["url"],
				"bio" => @artistinfo["artist"]["bio"]["summary"],
				"image" => @artistinfo["artist"]["image"][2]["#text"]
			}
		end
		return artist
	end

end
