require 'sqlite3'

DB = SQLite3::Database.new("music.db")
DB.results_as_hash = true

class Artist
  def initialize(name, id = nil)
    @id = id
    @name = name.downcase
  end

  def save
    DB.execute("INSERT INTO artists (name) VALUES ('#{@name}');")
  end

  def self.find(name)
    name = name.downcase
    record = DB.execute("SELECT * FROM artists WHERE name = '#{name}';")
    record = record[0]
    Artist.new(record["name"],record["id"])
  end

end

# x = Artist.new("Gungor")
# x.save
stuff = Artist.find("Gungor")
p stuff

# DB.execute("INSERT INTO songs (title,artist_id,rating,length) VALUES ('Gold',32,5,4);")

# DB.execute("INSERT INTO artists (name) VALUES ('Glass Animals');")

# record = DB.execute("SELECT * FROM artists WHERE name = 'Gungor';")

# p record[0]

# DB.execute("DELETE FROM artists;")

# p DB.execute("SELECT * FROM artists;")