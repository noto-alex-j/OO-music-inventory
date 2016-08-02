require 'sqlite3'
require 'pry'

DB = SQLite3::Database.new("music.db")
DB.results_as_hash = true

class Song
  def initialize(title,artist,album,genre,rating,length,id = nil)
    @title = title.downcase
    @artist = artist
    @album = album
    @genre = genre
    @rating = rating
    @length = length
    @id = id
  end

  def save
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
    
    DB.execute("INSERT INTO songs (title,album_id,rating,length) VALUES ('#{@title}',#{albumid},#{@rating},#{@length});")
  end

  def self.find(title)
    title = title.downcase
    record = DB.execute("SELECT * FROM songs WHERE title = '#{title}';")
    record = record[0]
    Album.new(record["title"],record["album_id"],record["rating"],record["length"],record["id"])
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
attr_reader :title
attr_reader :id

  def initialize(title,artistid,id = nil)
    @title = title.downcase
    @artist = artistid
    @id = id
  end

  def save
    DB.execute("INSERT INTO albums (title,artist_id) VALUES ('#{@title}',#{@artist});")
  end

  def self.find(title)
    title = title.downcase
    record = DB.execute("SELECT * FROM albums WHERE title = '#{title}';")
    record = record[0]
    if record != nil
    	Album.new(record["title"],record["artist_id"],record["id"])
    else
    	return nil
    end
  end

end

x = Song.new("Gold","Chet Faker","Textures","Pop",5,6)
x.save

# x = Album.find("Textures")
# p x

# DB.execute("INSERT INTO songs (title,artist_id,rating,length) VALUES ('Gold',32,5,4);")

# DB.execute("INSERT INTO albums (title,artist_id,genre,rating) VALUES ('Textures',5,'Blues',10);")

# record = DB.execute("SELECT * FROM artists WHERE name = 'Gungor';")

# p record[0]

# DB.execute("DELETE FROM albums;")

# p DB.execute("SELECT * FROM albums;")




