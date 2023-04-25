//
//  LoginViewController.swift
//  Animals
//
//  Created by Paolo Prodossimo Lopes on 24/04/23.
//

import UIKit
import SnapKit
import Hero

final class LoginViewController: UIViewController {
    
    private lazy var usernameLabel: UITextField = {
        let label = UITextField()
        label.placeholder = "Username"
        label.backgroundColor = Theme.white
        label.layer.cornerRadius = 8
        return label
    }()
    
    private lazy var passwordLabel: UITextField = {
        let label = UITextField()
        label.placeholder = "Password"
        label.backgroundColor = Theme.white
        label.layer.cornerRadius = 8
        return label
    }()
    
    private lazy var enterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Enter", for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = Theme.green500
        button.isUserInteractionEnabled = true
        
        button.addTarget(self, action: #selector(onEnterTapHandler), for: .touchUpInside)
        return button
    }()
    
    private lazy var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 5
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        commomInit()
    }
    
    private func commomInit() {
        configureStyle()
        configureHierarchy()
        configureConstraints()
    }
    
    private func configureHierarchy() {
        verticalStack.addArrangedSubview(usernameLabel)
        verticalStack.addArrangedSubview(passwordLabel)
        verticalStack.addArrangedSubview(enterButton)
        view.addSubview(verticalStack)
    }
    
    private func configureConstraints() {
        usernameLabel.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        passwordLabel.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        enterButton.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        verticalStack.snp.makeConstraints {
            $0.centerX.equalTo(view.snp.centerX)
            $0.centerY.equalTo(view.snp.centerY)
            $0.leading.equalTo(view.snp.leading).offset(16)
            $0.trailing.equalTo(view.snp.trailing).offset(-16)
        }
    }
    
    private func configureStyle() {
        view.backgroundColor = Theme.gray800
    }
    
    @objc private func onEnterTapHandler() {
        let homeController = HomeViewController()
        homeController.hero.isEnabled = true
        homeController.hero.modalAnimationType = .slide(direction: .up)
        
        present(homeController, animated: true)
    }
}
