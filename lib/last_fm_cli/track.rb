class LastFM::Track

  attr_accessor :name, :artist, :url, :playcount, :listeners, :length, :tags
  @@all = []

  def initialize(name = nil, artist = nil, url = nil, playcount = nil, listeners = nil)
    @name, @artist, @url, @playcount, @listeners= name, artist, url, playcount, listeners
    @@all << self
  end

  def self.all
    @@all
  end

end