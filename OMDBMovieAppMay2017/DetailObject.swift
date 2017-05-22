 
import Foundation
 
public class DetailObject {
    public var title : String?
    public var year : Int?
    public var rated : String?
    public var released : String?
    public var runtime : String?
    public var genre : String?
    public var director : String?
    public var writer : String?
    public var actors : String?
    public var plot : String?
    public var language : String?
    public var country : String?
    public var awards : String?
    public var poster : String?
    public var metascore : Int?
    public var imdbRating : Double?
    public var imdbVotes : String?
    public var imdbID : String?
    public var type : String?
    public var response : Bool?
    
 
    public class func modelsFromDictionaryArray(array:NSArray) -> [DetailObject]
    {
        var models:[DetailObject] = []
        for item in array
        {
            models.append(DetailObject(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
 
    required public init?(dictionary: NSDictionary) {
        
        title = dictionary["Title"] as? String
        year = dictionary["Year"] as? Int
        rated = dictionary["Rated"] as? String
        released = dictionary["Released"] as? String
        runtime = dictionary["Runtime"] as? String
        genre = dictionary["Genre"] as? String
        director = dictionary["Director"] as? String
        writer = dictionary["Writer"] as? String
        actors = dictionary["Actors"] as? String
        plot = dictionary["Plot"] as? String
        language = dictionary["Language"] as? String
        country = dictionary["Country"] as? String
        awards = dictionary["Awards"] as? String
        poster = dictionary["Poster"] as? String
        metascore = dictionary["Metascore"] as? Int
        imdbRating = dictionary["imdbRating"] as? Double
        imdbVotes = dictionary["imdbVotes"] as? String
        imdbID = dictionary["imdbID"] as? String
        type = dictionary["Type"] as? String
        response = dictionary["Response"] as? Bool
    }
    
    
 
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.title, forKey: "Title")
        dictionary.setValue(self.year, forKey: "Year")
        dictionary.setValue(self.rated, forKey: "Rated")
        dictionary.setValue(self.released, forKey: "Released")
        dictionary.setValue(self.runtime, forKey: "Runtime")
        dictionary.setValue(self.genre, forKey: "Genre")
        dictionary.setValue(self.director, forKey: "Director")
        dictionary.setValue(self.writer, forKey: "Writer")
        dictionary.setValue(self.actors, forKey: "Actors")
        dictionary.setValue(self.plot, forKey: "Plot")
        dictionary.setValue(self.language, forKey: "Language")
        dictionary.setValue(self.country, forKey: "Country")
        dictionary.setValue(self.awards, forKey: "Awards")
        dictionary.setValue(self.poster, forKey: "Poster")
        dictionary.setValue(self.metascore, forKey: "Metascore")
        dictionary.setValue(self.imdbRating, forKey: "imdbRating")
        dictionary.setValue(self.imdbVotes, forKey: "imdbVotes")
        dictionary.setValue(self.imdbID, forKey: "imdbID")
        dictionary.setValue(self.type, forKey: "Type")
        dictionary.setValue(self.response, forKey: "Response")
        
        return dictionary
    }
    
}
