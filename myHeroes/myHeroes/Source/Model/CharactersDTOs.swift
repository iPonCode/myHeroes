//  CharactersDTOs.swift
//  myHeroes
//
//  Created by Simón Aparicio on 01/04/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import Foundation

// MARK: Response
public struct NetworkResponseDTO: Codable {
    let code: Int
    let status, copyright, attributionText, attributionHTML: String?
    let etag: String?
    let data: ResponseDataDTO?
    
    private enum CodingKeys: String, CodingKey {
        case code, status, copyright, attributionText, attributionHTML, etag, data
    }
}

public struct ResponseDataDTO: Codable {
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

public struct ComicsItemDTO: Codable {
    let resourceURI: String
    let name: String
}
