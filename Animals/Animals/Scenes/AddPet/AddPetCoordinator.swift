//
//  AddPetCoordinator.swift
//  Animals
//
//  Created by Paolo Prodossimo Lopes on 26/04/23.
//

import UIKit

final class AddPetCoordinator: Coorindator {
    let root: UIViewController
    private(set) var childrens = [Coorindator]()
    
    init(root: UIViewController) {
        self.root = root
    }
    
    func start() {
        let repository = MoyaRepostory()
        let controller = AddPetViewController(repository: repository)
        controller.onCloseAction = { [weak controller, weak root] in
            controller?.dismiss(animated: true)
            root?.viewWillAppear(true)
        }
        
        controller.presentAlertError = { [weak controller] error in
            let action = UIAlertAction(title: "ok", style: .cancel)
            let alert = UIAlertController.init(title: "Erro", message: error.localizedDescription, preferredStyle: .actionSheet)
            alert.addAction(action)
            
            controller?.present(alert, animated: true)
        }
        controller.modalPresentationStyle = .overCurrentContext
        root.present(controller, animated: true)
    }
}
