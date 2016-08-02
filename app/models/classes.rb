class Song
  def initialize(title,albumid,rating,length)
    @title = title
    @album = albumid
    @rating = rating
    @length = length
  end

  def save
    DB.execute("INSERT INTO songs (title,album_id,rating,length) VALUES ('#{@title}',#{@album},#{@rating},#{@length});")
  end

end


class Artist
  def initialize(name)
    @name = name
  end

  def save
    DB.execute("INSERT INTO artists (name) VALUES ('#{@name}');")
  end

end


class Album
  def initialize(title,artistid,genre,rating)
    @title = title
    @artist = artistid
    @genre = genre
    @rating = rating
  end

  def save
    DB.execute("INSERT INTO albums (title,artist_id,genre,rating) VALUES ('#{@title}',#{@artist},#{@genre},#{@rating});")
  end

end
