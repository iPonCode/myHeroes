//  SortingType.swift
//  myHeroes
//
//  Created by Simón Aparicio on 27/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import Foundation

enum SortingType: Int, CaseIterable { // Needs to iterate over allcases using a ForEach
    
    case byName = 0
    case byId = 1
    case byAvailableComics = 2
    case byAvailableEvents = 3
    case watched = 4
    case favourite = 5
    case featured = 6

    init(type: Int) {
        
        switch type {
        case 0:
            self = .byName
        case 1:
            self = .byId
        case 2:
            self = .byAvailableComics
        case 3:
            self = .byAvailableEvents
        case 4:
            self = .watched
        case 5:
            self = .favourite
        case 6:
            self = .featured
        default:
            self = .byName
        }
    }
    
    var description : String { // the text for each case
        
        switch self {
        case .byName:
            return "Character name"
        case .byId:
            return "Character ID"
        case .byAvailableComics:
            return "Comics (available)"
        case .byAvailableEvents:
            return "Events (available)"
        case .watched:
            return "Checked as Watched"
        case .favourite:
            return "Checked as Favourite"
        case .featured:
            return "Checked as Featured"
        }
    }
    
    func sortingPredicate(descOrder: Bool = true) -> ((CharacterListItemDTO, CharacterListItemDTO) -> Bool){
        
        switch self {
            case .byName:
                return { descOrder ? ($0.name ?? "" < $1.name ?? "") : ($0.name ?? "" > $1.name ?? "") }
            case .byId:
                return { descOrder ? ($0.id < $1.id) : ($0.id > $1.id) }
            case .byAvailableComics:
                return { descOrder ? ($0.comics.available < $1.comics.available) : ($0.comics.available > $1.comics.available) }
            case .byAvailableEvents:
                return { descOrder ? ($0.events?.count ?? 0 < $1.events?.count ?? 0) : ($0.events?.count ?? 0 > $1.events?.count ?? 0) }
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
            return "in ascending order"
        case .descending:
            return "in descending order"
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
