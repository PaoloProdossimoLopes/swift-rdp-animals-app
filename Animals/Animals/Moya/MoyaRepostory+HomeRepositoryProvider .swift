//
//  MoyaRepostory+PetsRepositoryProvider .swift
//  Animals
//
//  Created by Paolo Prodossimo Lopes on 26/04/23.
//

import Foundation

extension MoyaRepostory: PetsRepositoryProvider {
    
    func loadPets(completion: @escaping (Result<[Pet], Error>) -> Void) {
        let request = Request(method: .GET)
        let endpoint = Endpoint.pets(request)
        provider.request(endpoint) { result in
            switch result {
            case let .success(response):
                let data = response.data
                let decoder = JSONDecoder()
                
                do {
                    let petsDecoded = try decoder.decode([PetResponse].self, from: data)
                    let pets = petsDecoded.map(Pet.init)
                    completion(.success(pets))
                } catch {
                    completion(.failure(RepositoryError.decodeFails))
                }
                
            case let .failure(error):
                completion(.failure(RepositoryError.receiveError(error)))
            }
        }
    }
}

extension Pet {
    init(response: PetResponse) {
        self.name = response.petName
        self.imageURL = response.petURL
    }
}
