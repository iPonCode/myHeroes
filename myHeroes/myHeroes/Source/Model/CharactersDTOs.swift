//  CharactersDTOs.swift
//  myHeroes
//
//  Created by Simón Aparicio on 01/04/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import Foundation

// MARK: List Response
public struct NetworkListResponseDTO: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String?
    let etag: String?
    let data: ListResponseDataDTO?
    
    private enum CodingKeys: String, CodingKey {
        case code, status, copyright, attributionText, attributionHTML, etag, data
    }
}

public struct ListResponseDataDTO: Codable {
    let offset, limit, total, count: Int
    let results: [CharacterListItemDTO]
}


// MARK: Character List
public struct CharacterListItemDTO: Codable, Identifiable {
    public let id: Int
    let name: String?
    let resultDescription: String?
    let thumbnail: ThumbnailDTO?
    let events, series: AvailableItemDTO?
    let comics: ComicsDTO
    var watched: Bool = Bool.random()
    var favourite: Bool = Bool.random()
    var featured: Bool = Bool.random()

    enum CodingKeys: String, CodingKey {
        case id, name, thumbnail, series, events, comics
        case resultDescription = "description"
    }
}

public struct ThumbnailDTO: Codable {
    let path: String
    let thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

public struct AvailableItemDTO: Codable {
    let count: Int
    
    enum CodingKeys: String, CodingKey {
        case count = "available"
    }
}

public struct ComicsDTO: Codable {
    let available: Int
    let collectionURI: String
    let items: [ComicsItemDTO]
    let returned: Int
}

public struct ComicsItemDTO: Codable, Identifiable {
    let resourceURI: String
    public let id: String
    
    enum CodingKeys: String, CodingKey {
        case resourceURI
        case id = "name"
    }
}


// MARK: Detail Response
public struct NetworkDetailResponseDTO: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String?
    let etag: String?
    let data: DetailResponseDataDTO?
    
    private enum CodingKeys: String, CodingKey {
        case code, status, copyright, attributionText, attributionHTML, etag, data
    }
}

public struct DetailResponseDataDTO: Codable {
    let offset, limit, total, count: Int
    let results: [CharacterDTO]
}

// MARK: Character Details
struct CharacterDTO: Codable {
    let id: Int
    let name, resultDescription: String
    let thumbnail: ThumbnailDTO
    let resourceURI: String
    let comics, series: ComicsDTO
    let stories: StoriesDTO
    let events: ComicsDTO
    let urls: [URLElementDTO]

    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
        case thumbnail, resourceURI, comics, series, stories, events, urls
    }
}

public struct StoriesDTO: Codable {
    let available: Int
    let collectionURI: String
    let items: [StoriesItemDTO]
    let returned: Int
}

public struct StoriesItemDTO: Codable {
    let resourceURI: String
    let name: String
    let type: String
}

public struct URLElementDTO: Codable {
    let type: String
    let url: String
}

