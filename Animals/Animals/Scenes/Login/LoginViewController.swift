//
//  LoginViewController.swift
//  Animals
//
//  Created by Paolo Prodossimo Lopes on 24/04/23.
//

import UIKit
import SnapKit
import Lottie

final class LoginViewController: UIViewController {
    
    var onEnterTap: (() -> Void)?
    
    private lazy var animatedImage: LottieAnimationView = {
        let av = LottieAnimationView(name: "lottie-dog-walking")
        av.loopMode = .loop
        av.animationSpeed = 1
        av.play()
        return av
    }()
    
    private lazy var usernameLabel: UITextField = {
        let label = makeTextField(placeholder: "Username")
        return label
    }()
    
    private lazy var passwordLabel: UITextField = {
        let label = makeTextField(placeholder: "Password")
        label.isSecureTextEntry = true
        return label
    }()
    
    private func makeTextField(placeholder: String) -> UITextField {
        let label = UITextField()
        label.backgroundColor = Theme.Color.white
        label.layer.cornerRadius = 8
        label.backgroundColor = Theme.Color.gray800
        label.textColor = Theme.Color.white
        label.attributedPlaceholder = NSAttributedString(
            string: placeholder,
            attributes: [.foregroundColor: Theme.Color.gray400]
        )
        return label
    }
    
    private lazy var enterButton: UIButton = {
        let button = UIButton()
        button.setTitle("Enter", for: .normal)
        button.layer.cornerRadius = 8
        button.backgroundColor = Theme.Color.green500
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
        verticalStack.addArrangedSubview(animatedImage)
        verticalStack.addArrangedSubview(usernameLabel)
        verticalStack.addArrangedSubview(passwordLabel)
        verticalStack.addArrangedSubview(enterButton)
        view.addSubview(verticalStack)
    }
    
    private func configureConstraints() {
        animatedImage.snp.makeConstraints {
            $0.height.equalTo(200)
        }
        
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
            $0.leading.equalTo(view.snp.leading).offset(Theme.Size.mid)
            $0.trailing.equalTo(view.snp.trailing).offset(-Theme.Size.mid)
        }
    }
    
    private func configureStyle() {
        view.backgroundColor = Theme.Color.gray800
    }
    
    @objc private func onEnterTapHandler() {
        onEnterTap?()
    }
}
