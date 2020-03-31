//  Fonts.swift
//  iListUI
//
//  Created by Simón Aparicio on 25/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import UIKit

extension UIFont {
    
    struct AppFont {
        
        static var largeTitle: UIFont {
            get {
                let fontSize = UIFont.preferredFont(forTextStyle: .largeTitle).pointSize
                if let descriptor = UIFont.systemFont(ofSize: fontSize, weight: .black)
                    .fontDescriptor.withDesign(.rounded) {
                    return UIFont(descriptor: descriptor, size: fontSize)

                } else {
                    return UIFont.preferredFont(forTextStyle: .largeTitle)
                }
            }
        }
        
        static var compactTitle: UIFont {
            get {
                let fontSize = UIFont.preferredFont(forTextStyle: .title1).pointSize
                if let descriptor = UIFont.systemFont(ofSize: fontSize, weight: .heavy)
                    .fontDescriptor.withDesign(.rounded) {
                    return UIFont(descriptor: descriptor, size: fontSize)

                } else {
                    return UIFont.preferredFont(forTextStyle: .title1)
                }
            }
        }

        static var barButton: UIFont {
            get {
                let fontSize = UIFont.preferredFont(forTextStyle: .title3).pointSize
                if let descriptor = UIFont.systemFont(ofSize: fontSize, weight: .bold)
                    .fontDescriptor.withDesign(.rounded) {
                    return UIFont(descriptor: descriptor, size: fontSize)

                } else {
                    return UIFont.preferredFont(forTextStyle: .headline)
                }
            }
        }
        
    }
}
