//  ImageLoader.swift
//  myHeroes
//
//  Created by Simón Aparicio on 02/04/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import Foundation

class ImageLoader: ObservableObject {

//    var didChange = PassthroughSubject<Data, Never>()
//
//    @Published var data = Data() {
//        didSet {
//            didChange.send(data)
//        }
//    }

    @Published var data = Data()
    
    init(url: String) {
        
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }.resume()
    }
}

