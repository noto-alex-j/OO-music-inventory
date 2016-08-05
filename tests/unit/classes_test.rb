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

  # Tests whether Song class creates new instance with correct format and
  # returns correct data via attr_reader
  def test_instance
    testsong = Song.new("White Owl","Josh Garrels","Hits","Folk",5,5)

    assert_equal("White Owl", testsong.songtitle)
  end

  def test_find_song
    foundsong = Song.find("White Owl")

    assert_equal("White Owl", foundsong.songtitle)
  end

  def test_artist_save_and_find
    testartist = Artist.new("James Blake")
    testartist.save

    foundartist = Artist.find("James Blake")

    assert_equal("James Blake", foundartist.name)
  end

  def test_album_save_and_find
    testalbum = Album.new("Overgrown", 1)
    testalbum.save

    foundalbum = Album.find("Overgrown")

    assert_equal("Overgrown", foundalbum.albumtitle)
  end

  def test_song_delete
    foundsong = Song.find("White Owl")
    
    if foundsong != "Not found"
      Song.delete(foundsong.id)
    end

    deletedsong = Song.find("White Owl")
    assert_equal("Not found",deletedsong)
  end

  def test_find_by_artist
    songs = Artist.findname("Josh Garrels")

    songs.each do |song|
      assert_equal("Josh Garrels", song["name"])
    end
  end

end

