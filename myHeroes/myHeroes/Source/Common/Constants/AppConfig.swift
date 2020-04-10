//  AppConfig.swift
//  myHeroes
//
//  Created by Simón Aparicio on 26/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import Foundation
import UIKit

// MARK: - App Configuration

struct AppConfig {
    
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
    static let emptyListIcon = "info.circle"
    
    // Screen size
    static let screenSize: CGRect = UIScreen.main.bounds
    static let screenWidth = screenSize.width
    static let screenHeight = screenSize.height
    static let halftScreenHeight = screenSize.height / 2
    static let widthBackgroundImageWidget = screenWidth - ((screenWidth * 8) / 100)
    static let maxHeightBackgroundImageWidget = screenHeight - ((screenHeight * 55) / 100)
    static let maxHeightHeaderImageWidget = screenHeight - ((screenHeight * 30) / 100)
    static let verticalLoadingTextOffset = (halftScreenHeight - ((halftScreenHeight * 20) / 100)) * -1

    // Cell Transition and gesture
    static let animationSpeedFactor: Double = 0.85
    static let minLongPressDuration: Double = 0.55
    
    // Default values for options
    static let selectedSorting: Int = 0 // byName is 0
    static let selectedSortingOption: Bool = false // descending is true
    static let showWatchedOnly: Bool = false
    static let showFavouriteOnly: Bool = false
    static let showFeaturedOnly: Bool = false
    static let minComicsAvailable: Int = 0

    // Stepper
    static let comicsStepJump: Int = 5
    static let comicsMinStepperValue: Int = 0
    static let comicsMaxStepperValue: Int = 75

    // This private constructor is so that the structure cannot be instantiated,
    // since it will only have static constants and are defined here
    private init() {}
    
}
