module SongORM
	def find(title)
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

  def all
    DB.execute(
      "SELECT songs.songtitle,songs.genre,songs.rating,songs.length,albums.albumtitle,artists.name,songs.album_id,songs.id
      FROM songs 
      JOIN albums ON songs.album_id = albums.id
      JOIN artists ON albums.artist_id = artists.id
      ;")
  end

  def delete(id)
    DB.execute("DELETE FROM songs WHERE id = #{id};")
  end

end

module ArtistORM
	def find(name)
    name = name.downcase.split.map do |x| x.capitalize end.join(" ")
    record = DB.execute("SELECT * FROM artists WHERE name = '#{name}';")
    record = record[0]
    if record != nil
      Artist.new(record["name"],record["id"])
    else
      return nil
    end
  end

  def findname(name)
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

module AlbumORM
	def find(title)
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












