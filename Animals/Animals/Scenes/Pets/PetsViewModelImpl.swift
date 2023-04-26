//
//  PetsViewModelImpl.swift
//  Animals
//
//  Created by Paolo Prodossimo Lopes on 26/04/23.
//

import Foundation

final class PetsViewModelImpl: PetsViewModel {
    
    var onCompletesWithPets: (([Pet]) -> Void)?
    var onCompletesWithoutPets: (() -> Void)?
    var onCompleteWithFailure: (() -> Void)?
    
    private let repository: PetsRepositoryProvider
    
    init(repository: PetsRepositoryProvider) {
        self.repository = repository
    }
    
    func loadPets() {
        repository.loadPets { [weak self] result in
            guard let self else { return }
            self.onResult(result)
        }
    }
    
    private func onResult(_ result: Result<[Pet], Error>) {
        switch result {
        case .success(let receivedPets):
            onSuccess(pets: receivedPets)
        case .failure(let error):
            onFailure(error: error)
        }
    }
    
    private func onSuccess(pets: [Pet]) {
        guard !pets.isEmpty else {
            onCompletesWithoutPets?()
            return
        }
        
        onCompletesWithPets?(pets)
    }
    
    private func onFailure(error: Error) {
        onCompleteWithFailure?()
    }
}
