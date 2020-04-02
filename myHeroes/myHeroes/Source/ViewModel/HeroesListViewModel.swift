//  HeroesListViewModel.swift
//  myHeroes
//
//  Created by Simón Aparicio on 31/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import Foundation
import Combine

class HeroesListViewModel: ObservableObject {
//    var didChange = PassthroughSubject<NetworkManager, Never>()
    
//    var chars = [CharacterListItemDTO]() {
//        didSet {
//            didChange.send(self)
//        }
//    }
        
    @Published var chars = [CharacterListItemDTO]()

    init() {
        
        //guard let url = URL(string: "https://ipon.es/apps/myHeroes/myHeroes.json") else { return }
        guard let url = URL(string: getCharactersListUrl()) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            guard let data = data else { return }
            
            let networkResponse = try! JSONDecoder().decode(NetworkResponseDTO.self, from: data)
            DispatchQueue.main.async {
                if let characters = networkResponse.data?.results{
                     self.chars = characters
                }
//                dump(networkResponse)
//                print("completed fetching json")
            }
        }.resume()
        
    }
    
    private func getCharactersListUrl() -> String {
        
/**
https://gateway.marvel.com:443/v1/public/characters?ts=1585767511&apikey=1de4fe3d3a6a89ba1e61bb34889865f1&hash=f67602dffc4512eda8d99bd7ee71e132
*/
        // TODO: Move Api configuration
        let baseUrl = "https://gateway.marvel.com:443/v1/public/characters"
        let privateKey = "8074772204a5fa9445ca96c81837f2b6d85b546b"
        let publicKey = "1de4fe3d3a6a89ba1e61bb34889865f1"
        let timeStamp = Date().timeIntervalSince1970
        let ts = String(format:"%.f",timeStamp)
        let hashChecksum = String(format: "%.f%@%@", timeStamp, privateKey, publicKey).md5()
        let url = baseUrl + "?ts=" + ts + "&apikey=" + publicKey + "&hash=" + hashChecksum
        return url
    }
}
