//  Constants.swift
//  iListUI
//
//  Created by Simón Aparicio on 26/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import Foundation

// For readability and to have all about configuration located in one place

// MARK: - App Configuration

struct AppConfig {

    // TODO: File names
    
    // Bar buttons
    static let barBack = "rectangle.grid.1x2.fill"
    static let barBackTrans = "rectangle.grid.1x2"
    static let barShowOptions = "table.badge.more.fill"
    static let barSaveOptions = "table.badge.more.fill"
    static let barCloseOptions = "table.badge.more.fill"
    
    // Menu icons
    static let menuFav = "star"
    static let menuUnFav = "star.slash"
    static let menuWatch = "eye"
    static let menuUnWatch = "eye.slash"
    static let menuRemove = "trash"
    static let menuFeat = "rectangle.expand.vertical"
    static let menuUnFeat = "rectangle.compress.vertical"

    // Cell icons
    static let cellFav = "star.fill"
    static let cellWatched = "eye.fill"
    static let popularityChar = ""

    // This private constructor is so that the structure cannot be instantiated,
    // since it will only have static constants and are defined here
    private init() {}
    
}

// MARK: - Api Configuration

struct ApiConfig {

    // TODO: URLs base for requests Servers
    static let baseURL: String = ""
    
    // TODO: Endpoints for diferent webservice
    enum EndPoint: String {
        case serverA = "serverA"
        case serverB = "serverB" // aditional endPoint
        
        init(value: String){
            self = EndPoint(rawValue: value) ?? EndPoint.serverA
        }
    }

    // TODO: Declare headers for webservice here if needed

    private init() {}
    
}


