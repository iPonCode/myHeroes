//  ItemListType.swift
//  myHeroes
//
//  Created by Simón Aparicio on 03/04/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import Foundation

enum ItemListType: Int, CaseIterable { // Needs to iterate over allcases using a ForEach
    
    case comics = 0
    case events = 1
    case series = 2

    init(type: Int) {
        
        switch type {
        case 0:
            self = .comics
        case 1:
            self = .events
        case 2:
            self = .series
        default:
            self = .comics
        }
    }
    
    var description : String { // the text for each case
        
        switch self {
        case .comics:
            return "Comics"
        case .events:
            return "Events"
        case .series:
            return "Series"
        }
    }
    
    func selectedItemList(_ charty: CharacterDTO) -> [ComicsItemDTO]{
        
        // the item list matching with each case
        switch self {
            case .comics:
                return charty.comics.items
            case .events:
                return charty.events.items
            case .series:
                return charty.series.items
        }
    }
    
}
