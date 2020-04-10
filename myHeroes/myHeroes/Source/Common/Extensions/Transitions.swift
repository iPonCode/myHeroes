//  Transitions.swift
//  myHeroes
//
//  Created by Simón Aparicio on 05/04/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import SwiftUI

extension AnyTransition {
    static var featuredCell: AnyTransition {
        AnyTransition.asymmetric(insertion: .scale(scale: 0.0, anchor: .bottom), removal: .scale(scale:0.5, anchor: .top))
    }

    static var standardCell: AnyTransition {
        AnyTransition.asymmetric(insertion: .scale(scale: 1.5, anchor: .bottom), removal: .scale(scale: 0.5, anchor: .top))
    }
}
