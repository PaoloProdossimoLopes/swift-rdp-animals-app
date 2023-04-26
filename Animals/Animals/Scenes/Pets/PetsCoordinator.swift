//
//  PetsCoordinator.swift
//  Animals
//
//  Created by Paolo Prodossimo Lopes on 25/04/23.
//

import UIKit
import Hero

final class PetsCoordinator: Coorindator {
    let root: UIViewController
    private(set) var childrens = [Coorindator]()
    
    init(root: UIViewController) {
        self.root = root
    }
    
    func start() {
        let repository = MoyaRepostory()
        let mainRepositoryDispatcher = DispachMainDecorator(repository)
        let viewModel = PetsViewModelImpl(repository: mainRepositoryDispatcher)
        let controller = PetsViewController(viewModel: viewModel)
        controller.modalPresentationStyle = .overCurrentContext
        controller.hero.isEnabled = true
        controller.hero.modalAnimationType = .cover(direction: .up)
        
        controller.coordinateToAddNewAnimal = coordinateToAddNewAnimalAdapter(
            controller: controller)

        root.present(controller, animated: true)
    }
    
    private func coordinateToAddNewAnimalAdapter(controller: UIViewController) -> (() -> Void) {
        return { [weak self, weak controller] in
            guard let self, let controller else { return }
            let coordinator = AddPetCoordinator(root: controller)
            coordinator.start()
            
            self.childrens.append(coordinator)
        }
    }
}

extension DispachMainDecorator: PetsRepositoryProvider where T: PetsRepositoryProvider {
    func loadPets(completion: @escaping (Result<[Pet], Error>) -> Void) {
        if Thread.isMainThread {
            return decoratee.loadPets(completion: completion)
        }
        
        decoratee.loadPets { [weak dispatcher] result in
            dispatcher?.async { [result] in
                completion(result)
            }
        }
    }
}
