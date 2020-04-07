//  ApiConfig.swift
//  myHeroes
//
//  Created by Simón Aparicio on 08/04/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import Foundation

// MARK: - Api Configuration

struct ApiConfig {

    static let baseUrl = "https://gateway.marvel.com:443/v1/public/characters"
    static let privateKey = "8074772204a5fa9445ca96c81837f2b6d85b546b"
    static let publicKey = "1de4fe3d3a6a89ba1e61bb34889865f1"
    
    static let charactersWebSearchUrl = "https://www.marvel.com/characters"

    // TODO: Declare headers for webservice here if needed
    
    // methods
    static func getCharactersListUrl() -> String {
        
        let timeStamp = Date().timeIntervalSince1970
        let ts = String(format:"%.f", timeStamp)
        let hashChecksum = String(format: "%.f%@%@",
                                  timeStamp,
                                  ApiConfig.privateKey,
                                  ApiConfig.publicKey).md5()
        return ApiConfig.baseUrl + "?ts=" + ts + "&apikey=" + ApiConfig.publicKey + "&hash=" + hashChecksum
    }

    static func getDetailsUrl(_ id: Int) -> String {
        
        let timeStamp = Date().timeIntervalSince1970
        let ts = String(format:"%.f", timeStamp)
        let hashChecksum = String(format: "%.f%@%@",
                                  timeStamp,
                                  ApiConfig.privateKey,
                                  ApiConfig.publicKey)
            .md5()

        return ApiConfig.baseUrl + "/" + String(id) + "?ts=" + ts + "&apikey=" +
               ApiConfig.publicKey + "&hash=" + hashChecksum
    }

    static func getComicsItemUrl(_ resourceURI: String) -> String {
        
        let timeStamp = Date().timeIntervalSince1970
        let ts = String(format:"%.f", timeStamp)
        let hashChecksum = String(format: "%.f%@%@",
                                  timeStamp,
                                  ApiConfig.privateKey,
                                  ApiConfig.publicKey).md5()
        return resourceURI + "?ts=" + ts + "&apikey=" + ApiConfig.publicKey + "&hash=" + hashChecksum
    }
    
    private init() {}
}
