# CLI Controller
require 'open-uri'
require 'net/http'
require 'json'
require 'nokogiri'

class LastFM::CLI

  attr_accessor :current_track, :current_playlist

  def call
    display_logo
    menu
  end

  def display_logo
    puts <<-DOC
     _              _      __           
    | |    __ _ ___| |_   / _|_ __ ___  
    | |   / _` / __| __| | |_| '_ ` _ \ 
    | |__| (_| \__ \ |_ _|  _| | | | | |
    |_____\__,_|___/\__(_)_| |_| |_| |_|
                                        
    DOC
    puts "Welcome to Last.fm!" 
    puts "\n\n\n"
  end
  def menu
    sleep(2)
    input = nil
    while input != "exit"
      puts "Enter \'tracks\' to display the list of the current top 50 tracks in the music chart."
      puts "Enter \'artists \' to display the artists that are currently featured in the music chart."
      puts "Enter \'exit\' to quit the program. \n\n"
      input = gets.strip.downcase
      tracks = fetch_tracks
      if input.to_i > 0 && input.to_i <= 50
        self.current_track = tracks[input.to_i - 1]
        song_details = fetch_song_details(self.current_track.url)
        self.current_track.length = song_details[0]
        self.current_track.tags = song_details[1]

        puts "\nSELECTED TRACK:"
        puts "TITLE: #{self.current_track.name}"
        puts "ARTIST: #{self.current_track.artist}"
        puts "LENGTH: #{self.current_track.length}"
        puts "TAGS: ##{self.current_track.tags.join(" | #")}"
        puts "PLAYCOUNT: #{self.current_track.playcount} times played"
        puts "LISTENERS: #{self.current_track.listeners} listeners"
        puts "\n\n"
        sleep(1)
      elsif input == "tracks"
        display_tracks(tracks)
        sleep(1.5)
        puts "\n\n"
      elsif input == "artists"
        artists
        sleep(1.5)
        puts "\n\n"
      elsif input != "exit"
        puts "Couldn't process input. \n\n"
        sleep(1.5)
      end
    end
  end
  
  def display_tracks(tracks)
    puts "Getting latest chart list:"
    tracks.each.with_index do |track, index|
      puts "#{index + 1}. #{track.name} | #{track.artist}"
    end
    puts "\n"

  end

  def fetch_tracks
    url = "http://ws.audioscrobbler.com/2.0/?method=chart.gettoptracks&api_key=288b248f6e952e9f02c5195dbd3409fc&format=json"
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    json = JSON.parse(response.body)
    json_tracks = json["tracks"]["track"]
    tracks = []
    json_tracks.each do |track|
      new_track = LastFM::Track.new(track["name"], track["artist"]["name"], track["url"], track["playcount"], track["listeners"])
      tracks << new_track
    end
    tracks
  end

  def fetch_song_details(song_url)
    #puts song
    song_details = []
    doc = Nokogiri::HTML(open(song_url))
    length = doc.css(".catalogue-metadata-description").text.strip
    song_details << length
    tag_array = []
    tags = doc.css(".tags-list").children.css("li").children.css("a")
    tags.each do |tag|
      tag_array << tag.text
    end
    song_details << tag_array
    song_details
  end

  def artists
    puts "Getting artists featured in the top chart"
    tracks = fetch_tracks
    artists = tracks.collect{|track| track.artist}.uniq.sort
    artists.each.with_index do |artist, index|
      puts "#{index + 1}. #{artist}"
    end
  end
end