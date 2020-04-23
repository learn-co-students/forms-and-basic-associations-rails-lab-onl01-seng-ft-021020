class SongsController < ApplicationController
  def index
    @songs = Song.all
  end

  def show
    set_song
  end

  def new
    @song = Song.new
    3.times { @song.notes.build }
    # Builds 3 "empty" notes that are automatically set up with the correct
    # parameter names to be used by accepts_nested_attributes_for
    # See:
    # https://api.rubyonrails.org/v5.2.3/classes/ActionView/Helpers/FormHelper.html#method-i-fields_for
  end

  def create
    artist = Artist.find_or_create_by(name: song_params[:artist_name])
    @song = artist.songs.build(song_params)

    if @song.save
      redirect_to songs_path
    else
      render :new
    end
  end

  def edit
    set_song
  end

  def update
    set_song
    @song.update(song_params)

    if @song.save
      redirect_to @song
    else
      render :edit
    end
  end

  def destroy
    set_song.destroy
    flash[:notice] = "Song deleted."
    redirect_to songs_path
  end

  private

  def song_params
    params.require(:song).permit(:title, :genre_id, :artist_name, notes_attributes: [:content])
  end

  def set_song
    @song = Song.find_by_id(params[:id])
  end
end

