require_relative 'orm'

class Song
  extend SongORM
  attr_reader :songtitle, :artist, :album, :genre, :rating, :length, :id

  # Using downcase/split/capitalize chain to make user input more consistent
  #
  def initialize(songtitle,artist,album,genre,rating,length,id = nil)
    @songtitle = songtitle.downcase.split.map do |x| x.capitalize end.join(" ")
    @artist = artist.downcase.split.map do |x| x.capitalize end.join(" ")
    @album = album.downcase.split.map do |x| x.capitalize end.join(" ")
    @genre = genre.downcase.split.map do |x| x.capitalize end.join(" ")
    @rating = rating
    @length = length
    @id = id
  end

  # First checks to see if artist and album exist in database and, if not, adds them
  #
  def save
    if Artist.find(@artist) == nil
      newartist = Artist.new(@artist)
      newartist.save
    end

    artistid = Artist.find(@artist).id

    if Album.find(@album) == nil
      newalbum = Album.new(@album,artistid)
      newalbum.save
    end

    albumid = Album.find(@album).id

    DB.execute("INSERT INTO songs (songtitle,album_id,genre,rating,length) VALUES ('#{@songtitle}',#{albumid},'#{@genre}',#{@rating},#{@length});")
  end

end


class Artist
  extend ArtistORM
  attr_reader :name, :id

  def initialize(name, id = nil)
    @name = name.downcase.split.map do |x| x.capitalize end.join(" ")
    @id = id
  end

  def save
    DB.execute("INSERT INTO artists (name) VALUES ('#{@name}');")
  end

end


class Album
  extend AlbumORM
  attr_reader :albumtitle, :id

  def initialize(albumtitle,artistid,id = nil)
    @albumtitle = albumtitle.downcase.split.map do |x| x.capitalize end.join(" ")
    @artist = artistid
    @id = id
  end

  def save
    DB.execute("INSERT INTO albums (albumtitle,artist_id) VALUES ('#{@albumtitle}',#{@artist});")
  end

end



