//  AnItem.swift
//  iListUI
//
//  Created by Simón Aparicio on 25/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import Foundation

struct AnItem: Identifiable {
    
    var id = UUID() // initialize the id with an universal unique identifier (128bits)
    
    var image: String
    var author: String
    var title: String
    var description: String
    var type: String
    var popularity: Int
    var watched: Bool = false
    var favourite: Bool = false
    var featured: Bool = false
    
}
