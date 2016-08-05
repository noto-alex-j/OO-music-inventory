class Song
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

  def self.find(title)
    title = title.downcase.split.map do |x| x.capitalize end.join(" ")
    record = DB.execute(
      "SELECT * 
      FROM songs 
      JOIN albums ON songs.album_id = albums.id
      JOIN artists ON albums.artist_id = artists.id
      WHERE songs.songtitle = '#{title}';"
      )
    record = record[0]
    # record returned as hash within array, record[0] removes it from array

    if record != nil
      Song.new(record["songtitle"],record["name"],record["albumtitle"],record["genre"],record["rating"],record["length"],record["id"])
    else
      return "Not found"
    end
  end

  def self.all
    DB.execute(
      "SELECT songs.songtitle,songs.genre,songs.rating,songs.length,albums.albumtitle,artists.name,songs.album_id,songs.id
      FROM songs 
      JOIN albums ON songs.album_id = albums.id
      JOIN artists ON albums.artist_id = artists.id
      ;")
  end

  def self.delete(id)
    DB.execute("DELETE FROM songs WHERE id = #{id};")
  end

end

class Artist
  attr_reader :name, :id

  def initialize(name, id = nil)
    @name = name.downcase.split.map do |x| x.capitalize end.join(" ")
    @id = id
  end

  def save
    DB.execute("INSERT INTO artists (name) VALUES ('#{@name}');")
  end

  def self.find(name)
    name = name.downcase.split.map do |x| x.capitalize end.join(" ")
    record = DB.execute("SELECT * FROM artists WHERE name = '#{name}';")
    record = record[0]
    if record != nil
      Artist.new(record["name"],record["id"])
    else
      return nil
    end
  end

  def self.findname(name)
    name = name.downcase.split.map do |x| x.capitalize end.join(" ")
    DB.execute(
      "SELECT songs.songtitle,songs.genre,songs.rating,songs.length,albums.albumtitle,artists.name,songs.album_id,songs.id
      FROM songs 
      JOIN albums ON songs.album_id = albums.id
      JOIN artists ON albums.artist_id = artists.id
      WHERE artists.name = '#{name}'
      ;")
  end

end


class Album
attr_reader :albumtitle, :id

  def initialize(albumtitle,artistid,id = nil)
    @albumtitle = albumtitle.downcase.split.map do |x| x.capitalize end.join(" ")
    @artist = artistid
    @id = id
  end

  def save
    DB.execute("INSERT INTO albums (albumtitle,artist_id) VALUES ('#{@albumtitle}',#{@artist});")
  end

  def self.find(title)
    title = title.downcase.split.map do |x| x.capitalize end.join(" ")
    record = DB.execute("SELECT * FROM albums WHERE albumtitle = '#{title}';")
    record = record[0]
    if record != nil
      Album.new(record["albumtitle"],record["artist_id"],record["id"])
    else
      return nil
    end
  end

end



