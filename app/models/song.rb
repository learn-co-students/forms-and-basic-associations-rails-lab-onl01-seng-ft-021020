
class Song < ActiveRecord::Base
belongs_to :artist
belongs_to :genre
has_many :notes

def artist_name
  self.artist.name if artist
end

def artist_name=(name)
  self.artist = Artist.find_or_create_by(name: name)
end

def note_contents=(notes)
  notes.each do |note|
    self.notes.build(content: note) if !note.empty?
  end
end

def note_contents
  self.notes.map{|note| note.content }
end

def genre_name
  self.genre.name if genre
end

def genre_name=(name)
  self.genre = Genre.find_or_create_by(name: name)
end

end
