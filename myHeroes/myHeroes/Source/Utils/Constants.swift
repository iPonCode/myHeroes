//  Constants.swift
//  myHeroes
//
//  Created by Simón Aparicio on 26/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import Foundation
import UIKit

// For readability and to have all about configuration located in one place

// MARK: - App Configuration

struct AppConfig {

    // TODO: File names
    
    // Bar buttons
    static let barBack = "rectangle.grid.1x2.fill"
    static let barBackTrans = "rectangle.grid.1x2"
    static let barShowOptions = "table.badge.more.fill"
    static let barSaveOptions = "rectangle.fill.badge.checkmark"
    static let barCloseOptions = "table.badge.more.fill"
    
    // Menu icons
    static let menuFeat = "rectangle.expand.vertical"
    static let menuUnFeat = "rectangle.compress.vertical"
    static let menuFav = "star"
    static let menuUnFav = "star.slash"
    static let menuWatch = "eye"
    static let menuUnWatch = "eye.slash"
    static let menuRemove = "trash"

    // Cell icons
    static let cellFav = "star.fill"
    static let cellWatched = "eye.fill"
    static let cellLink = "link.circle"
    
    // Screen size
    static let screenSize: CGRect = UIScreen.main.bounds
    static let screenWidth = screenSize.width
    static let screenHeight = screenSize.height
    static let widthBackgroundImageWidget = screenWidth - ((screenWidth * 8) / 100)
    static let maxHeightBackgroundImageWidget = screenHeight - ((screenHeight * 55) / 100)
    static let maxHeightHeaderImageWidget = screenHeight - ((screenHeight * 60) / 100)

    // This private constructor is so that the structure cannot be instantiated,
    // since it will only have static constants and are defined here
    private init() {}
    
}

// MARK: - Api Configuration

struct ApiConfig {

    static let baseUrl = "https://gateway.marvel.com:443/v1/public/characters"
    static let privateKey = "8074772204a5fa9445ca96c81837f2b6d85b546b"
    static let publicKey = "1de4fe3d3a6a89ba1e61bb34889865f1"
    
    static let charactersWebSearchUrl = "https://www.marvel.com/characters"

    // TODO: Declare headers for webservice here if needed

    private init() {}
    
}


