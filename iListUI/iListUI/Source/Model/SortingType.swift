//  SortingType.swift
//  iListUI
//
//  Created by Simón Aparicio on 27/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import Foundation

enum SortingType: Int, CaseIterable { // Needs to iterate over allcases using a ForEach
    
    case alphabetical = 0
    case byAuthor = 1
    case byType = 2
    case popularity = 3
    case watched = 4
    case favourite = 5
    case featured = 6

    init(type: Int) {
        
        switch type {
        case 0:
            self = .alphabetical
        case 1:
            self = .byAuthor
        case 2:
            self = .byType
        case 3:
            self = .popularity
        case 4:
            self = .watched
        case 5:
            self = .favourite
        case 6:
            self = .featured
        default:
            self = .alphabetical
        }
    }
    
    var description : String { // the text for each case
        
        switch self {
        case .alphabetical:
            return "Alfabéticamente (título)"
        case .byAuthor:
            return "Por autor"
        case .byType:
            return "Por tipo"
        case .popularity:
            return "Popularidad"
        case .watched:
            return "Vistos"
        case .favourite:
            return "Favoritos"
        case .featured:
            return "Destacados"
        }
    }
    
    func sortingPredicate() -> ((AnItem, AnItem) -> Bool){
        
        switch self {
            case .alphabetical:
                return {$0.title < $1.title}
            case .byAuthor:
                return {$0.author < $1.author}
            case .byType:
                return {$0.type < $1.type}
            case .popularity:
                return {$0.popularity < $1.popularity}
            case .watched:
                return {$0.watched && !$1.watched}
            case .favourite:
                return {$0.favourite && !$1.favourite}
            case .featured:
                return {$0.featured && !$1.featured}
        }
    }
    
    func sortingPredicate(descOrder: Bool = true) -> ((AnItem, AnItem) -> Bool){
        
        switch self {
            case .alphabetical:
                return descOrder ? {$0.title < $1.title} : {$0.title > $1.title}
            case .byAuthor:
                return descOrder ? {$0.author < $1.author} : {$0.author > $1.author}
            case .byType:
                return descOrder ? {$0.type < $1.type} : {$0.type > $1.type}
            case .popularity:
                return descOrder ? {$0.popularity < $1.popularity} : {$0.popularity > $1.popularity}
            case .watched:
                return descOrder ? {$0.watched && !$1.watched} : {!$0.watched && $1.watched}
            case .favourite:
                return descOrder ? {$0.favourite && !$1.favourite} : {!$0.favourite && $1.favourite}
            case .featured:
                return descOrder ? {$0.featured && !$1.featured} : {!$0.featured && $1.featured}
        }
    }
    
}

enum SortingOptionType: Int, CaseIterable {
    case ascending = 0
    case descending = 1
    
    init(option: Int){
        
        switch option {
        case 0:
            self = .ascending
        case 1:
            self = .descending
        default:
            self = .descending
        }
    }
    
    var description: String {
        
        switch self {
        case .ascending:
            return "Orden ascendente"
        case .descending:
            return "Orden descendente"
        }
    }
    
    func boolMe() -> Bool {
        
        switch self {
        case .ascending:
            return false
        case .descending:
            return true
        }
    }
    
}
