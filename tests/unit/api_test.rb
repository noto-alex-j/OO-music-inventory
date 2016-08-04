require 'test_helper'

class Songstest < Minitest::Test

  # Setup deletes all existing records from test database
  # Then creates new instance of Song class and saves to test database
  # Song save method also utilizes Artist & Album save methods, so those
  # methods are automatically tested in the setup.
  def setup
    super

    DB.execute("DELETE FROM songs")
    DB.execute("DELETE FROM artists")
    DB.execute("DELETE FROM albums")

    Song.new("White Owl","Josh Garrels","Hits","Folk",5,5).save
    Song.new("Gold","Chet Faker","Built on Glass","Blues",5,5).save
    Song.new("Let It Go","Gungor","I Am Mountain","Folk",5,5).save
    Song.new("Ulysses","Josh Garrels","Love and War","Folk",5,5).save
    
  end

  def test_albums
    info = TopAlbum.new("Josh Garrels").getTopAlbumInfo

    refute_nil info
  end

  def test_tracks
    info = TopTrack.new("Josh Garrels").getTopTrackInfo

    refute_nil info
  end

  def test_artist
    artist = ArtistInfo.new("Josh Garrels")
    similar = artist.getSimilarArtistInfo
    artistinfo = artist.getArtistInfo

    refute_nil similar
    refute_nil artistinfo
  end

end