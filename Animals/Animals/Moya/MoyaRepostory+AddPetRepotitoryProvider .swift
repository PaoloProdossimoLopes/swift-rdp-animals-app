//
//  MoyaRepostory+AddPetRepotitoryProvider .swift
//  Animals
//
//  Created by Paolo Prodossimo Lopes on 26/04/23.
//

import Foundation

extension MoyaRepostory: AddPetRepotitoryProvider {
    func registerPet(_ pet: NewPet, completion: @escaping (Error?) -> Void) {
        let request = Request(method: .POST, params: [
            "url": "",
            "name": pet.name,
            "age": pet.age,
        ])
        let endpoint = Endpoint.pets(request)
        provider.request(endpoint) { result in
            switch result {
            case .success:
                completion(nil)
            case .failure(let error):
                completion(error)
            }
        }
    }
}

struct NewPetDTO {
    
}
