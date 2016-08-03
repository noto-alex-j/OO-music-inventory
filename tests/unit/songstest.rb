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

    assert_equal("White Owl", newsong.songtitle)
  end
