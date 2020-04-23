class Song < ActiveRecord::Base
  # add associations here
  belongs_to :artist 
  belongs_to :genre
  has_many :notes 
  accepts_nested_attributes_for :notes, :reject_if => proc { |attrs| attrs[:content].blank? }

  def artist_name=(name)
    self.artist = Artist.find_or_create_by(name: name)
  end

  def artist_name
    artist.try(:name)
    # @artist.name if @artist
  end
end

# .try method
# if the receiver does not respond the call returns nil 
# rather than raising an exception