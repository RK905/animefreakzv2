//
//  Items_Base.swift
//  AnimeFreakz
//
//  Created by Rayen Kamta on 11/8/17.
//  Copyright © 2017 Rayen Kamta. All rights reserved.
//

import Foundation

public class Items_Base {
    public var items : Array<Items>?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let json4Swift_Base_list = Json4Swift_Base.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of Json4Swift_Base Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [Items_Base]
    {
        var models:[Items_Base] = []
        for item in array
        {
            models.append(Items_Base(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let json4Swift_Base = Json4Swift_Base(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: Json4Swift_Base Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        if (dictionary["items"] != nil) { items = Items.modelsFromDictionaryArray(array: dictionary["items"] as! NSArray) }
    }
    
    
    /**
     Returns the dictionary representation for the current instance.
     
     - returns: NSDictionary.
     */
    public func dictionaryRepresentation() -> NSDictionary {
        
        let dictionary = NSMutableDictionary()
        
        
        return dictionary
    }
    
}


