//  OptionsFactory.swift
//  myHeroes
//
//  Created by Simón Aparicio on 27/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import Foundation
import Combine

final class OptionsFactory: ObservableObject{

    @Published var defaults: UserDefaults

    init(defaults: UserDefaults = .standard) {

        self.defaults = defaults
        defaults.register(defaults: [
            "app.view.options.selectedSorting": AppConfig.selectedSorting,
            "app.view.options.selectedSortingOption": AppConfig.selectedSortingOption,
            "app.view.options.showWatchedOnly": AppConfig.showWatchedOnly,
            "app.view.options.showFavouriteOnly": AppConfig.showFavouriteOnly,
            "app.view.options.showFeaturedOnly": AppConfig.showFeaturedOnly,
            "app.view.options.minComicsAvailable": AppConfig.minComicsAvailable
        ])
    }

    var selectedSorting: SortingType{
        get { SortingType(type: defaults.integer(forKey: "app.view.options.selectedSorting")) }
        set { defaults.set(newValue.rawValue, forKey: "app.view.options.selectedSorting") }
    }

    var selectedSortingOption: SortingOptionType{
        get{ SortingOptionType(option: defaults.integer(forKey: "app.view.options.selectedSortingOption")) }
        set{ defaults.set(newValue.rawValue, forKey: "app.view.options.selectedSortingOption") }
    }

    var showWatchedOnly: Bool{
        get { defaults.bool(forKey: "app.view.options.showWatchedOnly") }
        set { defaults.set(newValue, forKey: "app.view.options.showWatchedOnly") }
    }

    var showFavouriteOnly: Bool{
        get{ defaults.bool(forKey: "app.view.options.showFavouriteOnly") }
        set{ defaults.set(newValue, forKey: "app.view.options.showFavouriteOnly") }
    }

    var showFeaturedOnly: Bool{
        get { defaults.bool(forKey: "app.view.options.showFeaturedOnly") }
        set { defaults.set(newValue, forKey: "app.view.options.showFeaturedOnly") }
    }

    var minComicsAvailable: Int{
        get { defaults.integer(forKey: "app.view.options.minComicsAvailable") }
        set { defaults.set(newValue, forKey: "app.view.options.minComicsAvailable") }
    }

}
