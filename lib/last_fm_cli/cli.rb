# CLI Controller
require 'open-uri'
require 'net/http'
require 'json'

class LastFM::CLI
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
  end
  def menu
    input = nil
    while input != "exit"
      puts "Welcome to Last.fm! \n Enter \'discover\' to display a list of the current top tracks in the music chart. \n Enter \'exit\' to quit the program."
      input = gets.strip.downcase
      case input
      when "discover"
        discover
      
      end
    end
  end

  def discover
    puts "Getting latest chart list:"
    url = "http://ws.audioscrobbler.com/2.0/?method=chart.gettoptracks&api_key=288b248f6e952e9f02c5195dbd3409fc&format=json"
    uri = URI.parse(url)
    response = Net::HTTP.get_response(uri)
    json = JSON.parse(response.body["tracks"])
    put json
    #@categories = Soundcloud::Category.today
  end
end