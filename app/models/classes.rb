class Song
  def initialize(title,artist,album,genre,minute,second,songrating,albumrating)
    @title = title
    @artist = artist 
    @album = album
    @genre = genre
    @lengthmin = minute
    @lengthsec = second
    @songrating = songrating
    @albumrating = albumrating
  end


  def songinfo
    @title = @title.split.map { |i| i.capitalize }.join(' ')
    @album = @album.split.map { |i| i.capitalize }.join(' ')
    @artist = @artist.split.map { |i| i.capitalize }.join(' ')
    return "#{@title}||#{@artist}||#{@album}||#{@genre}||#{@lengthmin}||#{@lengthsec}||#{@songrating}||#{@albumrating}\n"
  end

  def songAdd2File(songfile)
   File.open('music_db.txt', 'a') {|file| file.puts "#{self.songfile()}" }
  end

end