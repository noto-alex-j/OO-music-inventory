class Song
  attr_reader :songtitle, :artist, :album, :genre, :rating, :length, :id

  def initialize(songtitle,artist,album,genre,rating,length,id = nil)
    @songtitle = songtitle.downcase
    @artist = artist
    @album = album
    @genre = genre
    @rating = rating
    @length = length
    @id = id
  end

  def save
    # artist = Artist.find_or_create_by_name(@artist)

    if Artist.find(@artist) == nil
      newartist = Artist.new(@artist)
      newartist.save
    end

    artistinfo = Artist.find(@artist)
    artistid = artistinfo.id

    if Album.find(@album) == nil
      newalbum = Album.new(@album,artistid)
      newalbum.save
    end

    albuminfo = Album.find(@album)
    albumid = albuminfo.id
    
    DB.execute("INSERT INTO songs (songtitle,album_id,genre,rating,length) VALUES ('#{@songtitle}',#{albumid},#{@genre},#{@rating},#{@length});")
  end

  def self.find(title)
    title = title.downcase
    record = DB.execute(
      "SELECT * 
      FROM songs 
      JOIN albums ON songs.album_id = albums.id
      JOIN artists ON albums.artist_id = artists.id
      WHERE songs.songtitle = '#{title}';"
      )
    record = record[0]
    Song.new(record["songtitle"],record["name"],record["albumtitle"],record["genre"],record["rating"],record["length"],record["id"])
  end

end

class Artist
  attr_reader :id, :name

  def initialize(name, id = nil)
    @name = name.downcase
    @id = id
  end

  def save
    DB.execute("INSERT INTO artists (name) VALUES ('#{@name}');")
  end

  def self.find(name)
    name = name.downcase
    record = DB.execute("SELECT * FROM artists WHERE name = '#{name}';")
    record = record[0]
    if record != nil
      Artist.new(record["name"],record["id"])
    else
      return nil
    end
  end

end


class Album
attr_reader :title, :id

  def initialize(albumtitle,artistid,id = nil)
    @albumtitle = albumtitle.downcase
    @artist = artistid
    @id = id
  end

  def save
    DB.execute("INSERT INTO albums (albumtitle,artist_id) VALUES ('#{@albumtitle}',#{@artist});")
  end

  def self.find(title)
    title = title.downcase
    record = DB.execute("SELECT * FROM albums WHERE albumtitle = '#{title}';")
    record = record[0]
    if record != nil
      Album.new(record["albumtitle"],record["artist_id"],record["id"])
    else
      return nil
    end
  end

end