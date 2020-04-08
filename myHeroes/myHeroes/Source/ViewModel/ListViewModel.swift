//  ListViewModel.swift
//  myHeroes
//
//  Created by Simón Aparicio on 31/03/2020.
//  Copyright © 2020 iPon.es. All rights reserved.
//

import Foundation
import Combine
import Alamofire

class ListViewModel: ObservableObject {
        
    @Published var chars = [CharacterListItemDTO]()
    @Published var serverError = ErrorResponse()

    init() {
        getCharacterList()
    }
    
    private func getCharacterList() {
        
        guard let url = URL(string: ApiConfig.getCharactersListUrl()) else { return }
        
        AF.request(url).responseJSON { response in
        
            guard let serverData = response.data, let networkResponse = try? JSONDecoder().decode(NetworkListResponseDTO.self, from: serverData) else {
        
                guard let serverData = response.data, let errorObject = try? JSONDecoder().decode(ErrorResponse.self, from: serverData) else {
                    
                    // Cannot decode the current error message, show generic error when don't know what error it is
                    self.serverError.code = "Generic"
                    self.serverError.message = "Generic server error - Cannot decode error message"

                    return
                }
        
                // Show any other error to user
                self.serverError = errorObject

                return
            }
            
            DispatchQueue.main.async {
                if let characters = networkResponse.data?.results{
                    self.chars = characters
                }
            }
        }
        
    }
    
}
