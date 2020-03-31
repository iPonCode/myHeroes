//  OptionsFactory.swift
//  iListUI
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
            "app.view.options.selectedSorting": 0,
            "app.view.options.selectedSortingOption": true,
            "app.view.options.showWatchedOnly": false,
            "app.view.options.showFavouriteOnly": false,
            "app.view.options.showFeaturedOnly": false,
            "app.view.options.maxPopularity": 5
        ])
    }
    
    
    var selectedSorting: SortingType{
        get{
            SortingType(type: defaults.integer(forKey: "app.view.options.selectedSorting"))
        }
        set{
            defaults.set(newValue.rawValue, forKey: "app.view.options.selectedSorting")
        }
    }

    var selectedSortingOption: SortingOptionType{
        get{
            SortingOptionType(option: defaults.integer(forKey: "app.view.options.selectedSortingOption"))
        }
        set{
            defaults.set(newValue.rawValue, forKey: "app.view.options.selectedSortingOption")
        }
    }

    var showWatchedOnly: Bool{
        get{
            defaults.bool(forKey: "app.view.options.showWatchedOnly")
        }
        set{
            defaults.set(newValue, forKey: "app.view.options.showWatchedOnly")
        }
    }

    var showFavouriteOnly: Bool{
        get{
            defaults.bool(forKey: "app.view.options.showFavouriteOnly")
        }
        set{
            defaults.set(newValue, forKey: "app.view.options.showFavouriteOnly")
        }
    }

    var showFeaturedOnly: Bool{
        get{
            defaults.bool(forKey: "app.view.options.showFeaturedOnly")
        }
        set{
            defaults.set(newValue, forKey: "app.view.options.showFeaturedOnly")
        }
    }

    var maxPopularity: Int{
        get{
            defaults.integer(forKey: "app.view.options.maxPopularity")
        }
        set{
            defaults.set(newValue, forKey: "app.view.options.maxPopularity")
        }
    }
    
}
