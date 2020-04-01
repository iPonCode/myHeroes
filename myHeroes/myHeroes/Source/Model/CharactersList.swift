//  CharactersList.swift
//  myHeroes
//
//  Created by Simón Aparicio on 01/04/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import Foundation

// MARK: - CharactersList
struct CharactersList: Codable {
    let code, status, copyright, attributionText: String
    let attributionHTML: String
    let data: DataClass
    let etag: String
}

// MARK: - DataClass
struct DataClass: Codable {
    let offset, limit, total, count: String
    let results: [Character]
}

// MARK: - Result
struct Character: Codable, Identifiable {
    var uuid = UUID() // initialize the id with an universal unique identifier (128bits)

    let id, name, resultDescription, modified: String
    let resourceURI: String
    let urls: [URLElement]
    let thumbnail: Thumbnail
    let comics: Comics
    let stories: Stories
    let events, series: Comics

    enum CodingKeys: String, CodingKey {
        case id, name
        case resultDescription = "description"
        case modified, resourceURI, urls, thumbnail, comics, stories, events, series
    }
}

// MARK: - Comics
struct Comics: Codable {
    let available, returned, collectionURI: String
    let items: [ComicsItem]
}

// MARK: - ComicsItem
struct ComicsItem: Codable {
    let resourceURI, name: String
}

// MARK: - Stories
struct Stories: Codable {
    let available, returned, collectionURI: String
    let items: [StoriesItem]
}

// MARK: - StoriesItem
struct StoriesItem: Codable {
    let resourceURI, name, type: String
}

// MARK: - Thumbnail
struct Thumbnail: Codable {
    let path, thumbnailExtension: String

    enum CodingKeys: String, CodingKey {
        case path
        case thumbnailExtension = "extension"
    }
}

// MARK: - URLElement
struct URLElement: Codable {
    let type, url: String
}

/** from json example:
 {
   "code": "int",
   "status": "string",
   "copyright": "string",
   "attributionText": "string",
   "attributionHTML": "string",
   "data": {
     "offset": "int",
     "limit": "int",
     "total": "int",
     "count": "int",
     "results": [
       {
         "id": "int",
         "name": "string",
         "description": "string",
         "modified": "Date",
         "resourceURI": "string",
         "urls": [
           {
             "type": "string",
             "url": "string"
           }
         ],
         "thumbnail": {
           "path": "string",
           "extension": "string"
         },
         "comics": {
           "available": "int",
           "returned": "int",
           "collectionURI": "string",
           "items": [
             {
               "resourceURI": "string",
               "name": "string"
             }
           ]
         },
         "stories": {
           "available": "int",
           "returned": "int",
           "collectionURI": "string",
           "items": [
             {
               "resourceURI": "string",
               "name": "string",
               "type": "string"
             }
           ]
         },
         "events": {
           "available": "int",
           "returned": "int",
           "collectionURI": "string",
           "items": [
             {
               "resourceURI": "string",
               "name": "string"
             }
           ]
         },
         "series": {
           "available": "int",
           "returned": "int",
           "collectionURI": "string",
           "items": [
             {
               "resourceURI": "string",
               "name": "string"
             }
           ]
         }
       }
     ]
   },
   "etag": "string"
 */
