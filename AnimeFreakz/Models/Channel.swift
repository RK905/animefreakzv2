//
//  Channel.swift
//  AnimeFreakz
//
//  Created by Rayen Kamta on 10/24/17.
//  Copyright © 2017 Rayen Kamta. All rights reserved.
//

import Foundation

internal class Channel {
    internal let id: String
    internal let name: String
    internal let image: String
    internal let description: String
    
    init(id: String, name: String, image: String, description : String) {
        self.id = id
        self.name = name
        self.image = image
        self.description = description
    }
}
