
import Foundation

/* For support, please feel free to contact me at https://www.linkedin.com/in/rayenkamta*/

public class Quotes {
    public var name : String?
    public var anime : String?
    public var quote : String?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let quotes_list = Quotes.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Quotes Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Quotes]
    {
        var models:[Quotes] = []
        for item in array
        {
            models.append(Quotes(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let quotes = Quotes(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: Quotes Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        name = dictionary["name"] as? String
        anime = dictionary["anime"] as? String
        quote = dictionary["quote"] as? String
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        dictionary.setValue(self.name, forKey: "name")
        dictionary.setValue(self.anime, forKey: "anime")
        dictionary.setValue(self.quote, forKey: "quote")
        
        return dictionary
    }
    
}

