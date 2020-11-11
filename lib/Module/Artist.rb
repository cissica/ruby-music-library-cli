require "pry"
    
class Artist 
    extend Concerns::Findable

    attr_accessor :name, :songs
    @@all = []
    def initialize(name)
        @name = name
        @songs = []
    end 
    
    def save 
        @@all << self
    end 

    def self.all
        @@all
    end 

    def self.destroy_all
        @@all.clear
    end 

    def self.create(name)
        artist = self.new(name)
        artist.save
        artist
    end 

    def songs
        @songs
    end 

    def add_song(song)
        song.artist = self unless song.artist
        songs << song unless songs.include?(song)
    end 

    def genres
        # self.songs.collect {|song| song.genre}
        songs.collect { |song| song.genre}.uniq
      end

end 