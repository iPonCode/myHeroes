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
        getDetails(id)
    }

    private func getDetails(_ id: Int) {

        guard let url = URL(string: ApiConfig.getDetailsUrl(id)) else { return }

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

}
