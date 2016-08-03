require 'test_helper'

class Songstest < Minitest::Test

  # Consider writing a `setup` function, which automatically runs before each
  # test. This one wipes the DB before each run, which can be helpful in
  # writing your tests--as they become fully self-contained.
  def setup
    super

    DB.execute("DELETE FROM songs")
    DB.execute("DELETE FROM artists")
    DB.execute("DELETE FROM albums")
  end

  def test_instance
    newsong = Song.new("White Owl","Josh Garrels","Hits","Folk",5,5)

    assert_equal("white owl", newsong.songtitle)
  end

  def test_save_and_find
    newsong = Song.new("White Owl","Josh Garrels","Hits","Folk",5,5)
    newsong.save

    # foundsong = Song.find("White Owl")
    # binding.pry
    # assert_equal("white owl", foundsong.songtitle)
  end

end