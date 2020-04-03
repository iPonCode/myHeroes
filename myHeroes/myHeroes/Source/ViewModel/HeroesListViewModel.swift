//  HeroesListViewModel.swift
//  myHeroes
//
//  Created by Simón Aparicio on 31/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import Foundation
//import Combine

class HeroesListViewModel: ObservableObject {
        
    @Published var chars = [CharacterListItemDTO]()

    init() {
        
        guard let url = URL(string: getCharactersListUrl()) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            guard let data = data else { return }
            
            let networkResponse = try! JSONDecoder().decode(NetworkResponseDTO.self, from: data)
            DispatchQueue.main.async {
                if let characters = networkResponse.data?.results{
                     self.chars = characters
                }
            }
        }.resume()
        
    }
    
    private func getCharactersListUrl() -> String {
        
        let timeStamp = Date().timeIntervalSince1970
        let ts = String(format:"%.f", timeStamp)
        let hashChecksum = String(format: "%.f%@%@",
                                  timeStamp,
                                  ApiConfig.privateKey,
                                  ApiConfig.publicKey).md5()
        return ApiConfig.baseUrl + "?ts=" + ts + "&apikey=" + ApiConfig.publicKey + "&hash=" + hashChecksum
    }
}
