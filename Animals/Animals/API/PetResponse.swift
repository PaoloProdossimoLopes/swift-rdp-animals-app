//
//  PetResponse.swift
//  Animals
//
//  Created by Paolo Prodossimo Lopes on 26/04/23.
//

import Foundation

struct PetResponse: Decodable {
    let petName: String
    let petURL: String
    
    enum CodingKeys: String, CodingKey {
        case petName = "nome"
        case petURL = "image-url"
    }
}
