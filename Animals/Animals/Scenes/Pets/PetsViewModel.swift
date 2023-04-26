//
//  PetsViewModel.swift
//  Animals
//
//  Created by Paolo Prodossimo Lopes on 26/04/23.
//

import Foundation

protocol PetsViewModel {
    var onCompletesWithPets: (([Pet]) -> Void)? { get set }
    var onCompletesWithoutPets: (() -> Void)? { get set }
    var onCompleteWithFailure: (() -> Void)? { get set }
    
    func loadPets()
}
