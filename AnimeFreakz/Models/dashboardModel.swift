//
//  dashboardModel.swift
//  AnimeFreakz
//
//  Created by Rayen Kamta on 10/18/17.
//  Copyright © 2017 Rayen Kamta. All rights reserved.
//

import Foundation


import Foundation

public class dashboardModel {
    public var dashboard : Array<Dashboard>?
    public var quotes : Array<Quotes>?
    public var music : Array<Music>?
    
    /**
     Returns an array of models based on given dictionary.
     
     Sample usage:
     let dashboardModel_list = dashboardModel.modelsFromDictionaryArray(someDictionaryArrayFromJSON)
     
     - parameter array:  NSArray from JSON dictionary.
     
     - returns: Array of dashboardModel Instances.
     */
    public class func modelsFromDictionaryArray(array:NSArray) -> [dashboardModel]
    {
        var models:[dashboardModel] = []
        for item in array
        {
            models.append(dashboardModel(dictionary: item as! NSDictionary)!)
        }
        return models
    }
    
    /**
     Constructs the object based on the given dictionary.
     
     Sample usage:
     let dashboardModel = dashboardModel(someDictionaryFromJSON)
     
     - parameter dictionary:  NSDictionary from JSON.
     
     - returns: dashboardModel Instance.
     */
    required public init?(dictionary: NSDictionary) {
        
        if (dictionary["dashboard"] != nil) { dashboard = Dashboard.modelsFromDictionaryArray(array: dictionary["dashboard"] as! NSArray) }
        if (dictionary["quotes"] != nil) { quotes = Quotes.modelsFromDictionaryArray(array: dictionary["quotes"] as! NSArray) }
        if (dictionary["music"] != nil) { music = Music.modelsFromDictionaryArray(array: dictionary["music"] as! NSArray) }

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
