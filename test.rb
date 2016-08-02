require 'sqlite3'

DB = SQLite3::Database.new("music.db")
DB.results_as_hash = true


# DB.execute("INSERT INTO songs (title,artist_id,rating,length) VALUES ('Gold',32,5,4);")

# DB.execute("INSERT INTO artists (name) VALUES ('Chet Faker');")

# puts DB.execute("SELECT * FROM songs;")

# DB.execute("DELETE FROM artists;")