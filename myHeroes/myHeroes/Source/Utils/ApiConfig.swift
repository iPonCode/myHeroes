//  ApiConfig.swift
//  myHeroes
//
//  Created by Simón Aparicio on 08/04/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import Foundation

// MARK: - Api Configuration

struct ApiConfig {

    static private let baseUrl = "https://gateway.marvel.com:443/v1/public/characters"
    static private let privateKey = "8074772204a5fa9445ca96c81837f2b6d85b546b"
    static private let publicKey = "1de4fe3d3a6a89ba1e61bb34889865f1"
    
    static let publicCharactersWebSearchUrl = "https://www.marvel.com/characters"

    // MARK: Methods to obtain the urls
    static func getCharactersListUrl() -> String {
        let timeStamp = getTimeStamp()
        return baseUrl + "?ts=" + timeStamp + "&apikey=" + publicKey + "&hash=" + getHashCecksum(ts: timeStamp)
    }
    
    static func getDetailsUrl(_ id: Int) -> String {
        let timeStamp = getTimeStamp()
        return baseUrl + "/" + String(id) + "?ts=" + timeStamp + "&apikey=" + publicKey + "&hash=" + getHashCecksum(ts: timeStamp)
    }

    static func getComicsItemUrl(_ resourceURI: String) -> String {
        let timeStamp = getTimeStamp()
        return resourceURI + "?ts=" + timeStamp + "&apikey=" + publicKey + "&hash=" + getHashCecksum(ts: timeStamp)
    }
    
    // MARK: Hash methods
    static private func getHashCecksum(ts: String) -> String {
        return String(format: "%@%@%@", ts, privateKey, publicKey).md5()
    }
    
    static private func getTimeStamp() -> String {
        // returns allways a different time stamp
        return String(format:"%.f", Date().timeIntervalSince1970)
    }
    
    // TODO: Declare headers for webservice here if needed
    
    private init() {}
}
