//
//  AddPetViewModelImpl.swift
//  Animals
//
//  Created by Paolo Prodossimo Lopes on 26/04/23.
//

import Foundation

protocol AddPetRepotitoryProvider {
    func registerPet(_ pet: NewPet, completion: @escaping (Error?) -> Void)
}

protocol AddPetViewModel {
    var onCompleteWithSuccess: (() -> Void)? { get set }
    var onCompleteWithFailure: ((Error) -> Void)? { get set }
    func createPet(_ pet: NewPet)
}

final class AddPetViewModelImpl: AddPetViewModel {
    var onCompleteWithSuccess: (() -> Void)?
    var onCompleteWithFailure: ((Error) -> Void)?
    
    private let repository: AddPetRepotitoryProvider
    
    init(repository: AddPetRepotitoryProvider) {
        self.repository = repository
    }
    
    func createPet(_ pet: NewPet) {
        repository.registerPet(pet) { [weak self] error in
            guard let self else { return }
            self.onResult(error: error)
        }
    }
    
    private func onResult(error: Error?) {
        if let error {
            onCompleteWithFailure?(error)
            return
        }
        
        onCompleteWithSuccess?()
    }
}
