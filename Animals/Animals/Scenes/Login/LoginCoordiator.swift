//
//  LoginCoordinator.swift
//  Animals
//
//  Created by Paolo Prodossimo Lopes on 25/04/23.
//

import UIKit
import Hero

final class LoginCoordiator: Coorindator {
    
    let controller = LoginViewController()
    var root: UIViewController {
        controller
    }
    private(set) var childrens = [Coorindator]()
    
    init(window: UIWindow?) {
        window?.rootViewController = root
        window?.makeKeyAndVisible()
    }
    
    func start() {
        controller.onEnterTap = onEnterTapAdpater(controller: controller)
    }
    
    private func onEnterTapAdpater(controller: LoginViewController) -> (() -> Void){
        return { [weak self, controller] in
            guard let self else { return }
            let coordiantor = PetsCoordinator(root: controller)
            coordiantor.start()
            self.childrens.append(coordiantor)
        }
    }
}
