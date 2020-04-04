//  DetailViewModel.swift
//  myHeroes
//
//  Created by Simón Aparicio on 03/04/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import Foundation
import Combine

class DetailViewModel: ObservableObject {
        
    @Published var charty = CharacterDTO()

    init(_ id: Int) {
        
        guard let url = URL(string: getDetailsUrl(id)) else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            guard let data = data else { return }
            
            let networkResponse = try! JSONDecoder().decode(NetworkDetailResponseDTO.self, from: data)
            DispatchQueue.main.async {
                if let character = networkResponse.data?.results.first{
                     self.charty = character
                }
            }
        }.resume()
        
    }
    
    private func getDetailsUrl(_ id: Int) -> String {
        
        let timeStamp = Date().timeIntervalSince1970
        let ts = String(format:"%.f", timeStamp)
        let hashChecksum = String(format: "%.f%@%@",
                                  timeStamp,
                                  ApiConfig.privateKey,
                                  ApiConfig.publicKey)
            .md5()

        return ApiConfig.baseUrl + "/" + String(id) + "?ts=" + ts + "&apikey=" +
               ApiConfig.publicKey + "&hash=" + hashChecksum
    }

    private func getComicsItemUrl(_ resourceURI: String) -> String {
        
        let timeStamp = Date().timeIntervalSince1970
        let ts = String(format:"%.f", timeStamp)
        let hashChecksum = String(format: "%.f%@%@",
                                  timeStamp,
                                  ApiConfig.privateKey,
                                  ApiConfig.publicKey).md5()
        return resourceURI + "?ts=" + ts + "&apikey=" + ApiConfig.publicKey + "&hash=" + hashChecksum
    }
}
