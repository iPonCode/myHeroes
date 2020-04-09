//  ImageLoader.swift
//  myHeroes
//
//  Created by Simón Aparicio on 02/04/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import Foundation

protocol DataManager {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

class ImageLoader: ObservableObject {

    @Published var data = Data()
    private var dataManager: DataManager?
    
    init(url: String, dataManager: DataManager? = URLSession.shared) {
        self.dataManager = dataManager
        getImage(url)
    }
    
    private func getImage(_ url: String) {
        
        // TODO: Use AlamofireImage
        guard let url = URL(string: url) else { return }
        dataManager?.dataTask(with: url) { (data, _, _) in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }.resume()
    }
    
}

extension URLSession: DataManager { } // for tests
