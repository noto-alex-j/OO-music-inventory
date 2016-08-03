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

    newsong = Song.new("White Owl","Josh Garrels","Hits","Folk",5,5)
    newsong.save
  end

  # Tests whether Song class creates new instance with correct format and
  # returns correct data via attr_reader
  def test_instance
    testsong = Song.new("White Owl","Josh Garrels","Hits","Folk",5,5)

    assert_equal("white owl", testsong.songtitle)
  end

  # Tests whether find method correctly finds song in database that was 
  # added in test setup
  def test_find_song
    foundsong = Song.find("White Owl")

    assert_equal("white owl", foundsong.songtitle)
  end

  def test_artist_save_and_find
    testartist = Artist.new("James Blake")
    testartist.save

    foundartist = Artist.find("James Blake")

    assert_equal("james blake", foundartist.name)
  end

  def test_album_save_and_find
    testalbum = Album.new("Overgrown", 1)
    testalbum.save

    foundalbum = Album.find("Overgrown")

    assert_equal("overgrown", foundalbum.albumtitle)
  end

  def test_song_delete
    foundsong = Song.find("White Owl")
    foundsong.delete

    deletedsong = Song.find("White Owl")
    assert_equal("Not found",deletedsong)
  end

end

