# require_relative 'secret.rb'
# require 'httparty'
# require 'pry'


 # Function adds the string being passed through the songfile variable into the 
 def songAdd2File(songfile)
   File.open('music_db.txt', 'a') {|z| z.puts "#{songfile}" }
 end


 # If file exists, do nothing. Otherwise, create the music_db file with the first row being headers.
 def createFileWithHeader 
   # TODO - See about using !File.exist?("music_db.txt")
   if File.exist?("music_db.txt")
   else
   open('music_db.txt', 'w') { |z|
   }
   end 
 end


 # Create an array of each line in the file as a variable.
 def createFileArray
     y = File.foreach("music_db.txt").map { |line| line.split("||") }
     grouped = y.group_by{|x| x[0]}.values
     return grouped 
   # end
 end
 
# -------- Methods for searching for and deleting songs --------

# Retrieves the music_db.txt file and converts it into an array to be searched through
def arrayToSearch
  @arraytosearch = Array.new
  File.foreach("music_db.txt").each do |x|
    x = x.split("||")
    @arraytosearch.push(x)
  end
  return @arraytosearch
end
  
# Searches array created above and pushes into an array any arrays that include the element searched for
# and then returns that array
def searchResult(search,arraytosearch)
  @searchresults = Array.new
  arraytosearch.each do |x|
    if x.include?(search)
      @searchresults.push(x)
    end
  end
  return @searchresults
end

# Searches array created above and pushes into an array any arrays that do not include the element entered
# into the delete form, and then returns that array
def allButDeleted(delete,arraytosearch)
  @deletesearchresults = Array.new
  arraytosearch.each do |x|
    if !x.include?(delete)
      @deletesearchresults.push(x)
    end
  end
  return @deletesearchresults
end

# Takes the array created above, which does not include the element entered into the delete form, and 
# overwrites it onto the music_db.txt file
def deleteResultToFile(allbutdeleted)
  @arraytofile = Array.new
  allbutdeleted.each do |x|
    x = x.join("||")
    @arraytofile.push(x)
  end
  File.open('music_db.txt', 'w') do |z| 
    @arraytofile.each do |line|
      z.puts line
    end
  end
end


def returnAlbums(arraytosearch)
  @albumarray = Array.new
  arraytosearch.each do |title,artist,album,genre,minutes,seconds,songrating,albumrating|
      @albumline = [album,artist,genre,albumrating]
      @albumarray.push(@albumline)
  end
  return @albumarray.uniq
end

def returnArtists(arraytosearch)
  @artistarray = Array.new
  arraytosearch.each do |title,artist,album,genre,minutes,seconds,songrating,albumrating|
      @artistline = artist
      @artistarray.push(@artistline)
  end
  return @artistarray.uniq
end








