//
//  PetsRepositoryProvider.swift
//  Animals
//
//  Created by Paolo Prodossimo Lopes on 25/04/23.
//

import Foundation

protocol PetsRepositoryProvider {
    func loadPets(completion: @escaping (Result<[Pet], Error>) -> Void)
}
