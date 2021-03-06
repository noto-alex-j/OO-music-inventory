require 'sqlite3'
require 'pry'

DB = SQLite3::Database.new("test.db")
DB.results_as_hash = true

class Song
  attr_reader :songtitle, :artist, :album, :genre, :rating, :length, :id

  def initialize(songtitle,artist,album,genre,rating,length,id = nil)
    @songtitle = songtitle.downcase.split.map do |x| x.capitalize end.join(" ")
    @artist = artist.downcase.split.map do |x| x.capitalize end.join(" ")
    @album = album.downcase.split.map do |x| x.capitalize end.join(" ")
    @genre = genre.downcase.split.map do |x| x.capitalize end.join(" ")
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

    DB.execute("INSERT INTO songs (songtitle,album_id,genre,rating,length) VALUES ('#{@songtitle}',#{albumid},'#{@genre}',#{@rating},#{@length});")
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

    if record != nil
      Song.new(record["songtitle"],record["name"],record["albumtitle"],record["genre"],record["rating"],record["length"],record["id"])
    else
      return "Not found"
    end
  end

  def self.all
    DB.execute(
      "SELECT * 
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
  attr_reader :id
  attr_reader :name

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
attr_reader :albumtitle
attr_reader :id

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



# x = Song.all
# p x

# x = Song.find("Goldsfdsd")
# p x

x = Song.new("saeer","Chet fxggjdgf","esrffgdfh","sesagsh",5,6)
# x.save

# x = Album.find("Textures")
# p x

# DB.execute("INSERT INTO songs (title,artist_id,rating,length) VALUES ('Gold',32,5,4);")

# DB.execute("INSERT INTO albums (title,artist_id,genre,rating) VALUES ('Textures',5,'Blues',10);")

# record = DB.execute("SELECT * FROM artists WHERE name = 'Gungor';")

# p record[0]

# DB.execute("DELETE FROM albums;")

# p DB.execute("SELECT * FROM songs;")




