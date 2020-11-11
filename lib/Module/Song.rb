require "pry"
class Song
    attr_accessor :name, :artist, :genre
    @@all = []
    def initialize(name, artist=nil, genre=nil)
        @name = name  
        self.artist=artist if artist
        self.genre=genre if genre
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
        song = self.new(name)
        song.save
        song 
    end 

    def artist=(artist)
        @artist = artist
        artist.add_song(self)
    end 

    def genre=(genre)
         @genre = genre
         if !(genre.songs.include?(self))
            genre.songs << self
         end 
     end 

     def self.find_by_name(name)
        all.detect{|s|s.name == name}
     end 

     def self.find_or_create_by_name(name)
        if self.find_by_name(name) 
            self.find_by_name(name)
        else
            self.create(name)
        end 
        #find_by_name(name) || create(name)
    end 

    def self.new_from_filename(file)
        file = file.gsub(".mp3", "").split(" - ")
        artist = file[0]
        name = file[1]
        genre = file[2]
        genre = Genre.find_or_create_by_name(genre)
        artist = Artist.find_or_create_by_name(artist)
        self.new(name, artist, genre)
        
    end 
            
    def self.create_from_filename(file)
        new_from_filename(file).tap{ |s| s.save}
    
    end

end 