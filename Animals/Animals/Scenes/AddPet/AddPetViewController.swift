//
//  AddPetViewController.swift
//  Animals
//
//  Created by Paolo Prodossimo Lopes on 26/04/23.
//

import UIKit
import Iconic
import SnapKit

struct NewPet {
    let name: String
    let age: String
}

final class AddPetViewController: UIViewController {
    
    var onCloseAction: (() -> Void)?
    var presentAlertError: ((Error) -> Void)?
    
    private var viewModel: AddPetViewModel
    
    init(viewModel: AddPetViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
    private lazy var closeButton: UIButton = {
        let button = UIButton()
        let image = FontAwesomeIcon.homeIcon.image(
            ofSize: .init(width: 30, height: 30),
            color: Theme.Color.green500
        )
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(closeActionHandler), for: .touchUpInside)
        return button
    }()
    
    private lazy var nameTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Nome"
        let image = FontAwesomeIcon.homeIcon.image(
            ofSize: .init(width: 50, height: 50),
            color: Theme.Color.gray300)
        tf.leftView = FontAwesomeIconView(image: image)
        return tf
    }()
    
    private lazy var ageTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "Idade"
        let image = FontAwesomeIcon.homeIcon.image(
            ofSize: .init(width: 50, height: 50),
            color: Theme.Color.gray300
        )
        tf.leftView = FontAwesomeIconView(image: image)
        return tf
    }()
    
    private lazy var loaderIndicator: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .medium)
        loader.tintColor = Theme.Color.white
        loader.color = Theme.Color.white
        loader.isHidden = true
        loader.hidesWhenStopped = true
        loader.stopAnimating()
        return loader
    }()
    
    private lazy var addNewPetButton: UIButton = {
        let button = UIButton()
        button.setTitle("adicionar pet", for: .normal)
        button.backgroundColor = Theme.Color.green500
        button.setTitleColor(Theme.Color.white, for: .normal)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(createNewPetActionHandler), for: .touchUpInside)
        return button
    }()
    
    private lazy var verticalIcon: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 10
        return stack
    }()
    
    private lazy var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = Theme.Color.white
        view.layer.cornerRadius = 8
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.onCompleteWithFailure = { [weak self] error in
            self?.presentAlertError?(error)
            self?.hideLoader()
        }
        
        viewModel.onCompleteWithSuccess = { [weak self] in
            self?.onCloseAction?()
            self?.hideLoader()
        }
        
        configureStyle()
        configureViewHierarchy()
        configureConstraint()
    }
    
    private func configureStyle() {
        view.backgroundColor = Theme.Color.black.withAlphaComponent(0.3)
    }
    
    private func configureViewHierarchy() {
        addNewPetButton.addSubview(loaderIndicator)
        
        verticalIcon.addArrangedSubview(closeButton)
        verticalIcon.addArrangedSubview(nameTextField)
        verticalIcon.addArrangedSubview(ageTextField)
        verticalIcon.addArrangedSubview(addNewPetButton)
        
        containerView.addSubview(verticalIcon)
        view.addSubview(containerView)
    }
    
    private func configureConstraint() {
        nameTextField.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        ageTextField.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        loaderIndicator.snp.makeConstraints {
            $0.center.equalTo(addNewPetButton)
            $0.height.width.equalTo(30)
        }
        
        addNewPetButton.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        containerView.snp.makeConstraints {
            $0.bottom.equalTo(view.snp.bottom)
            $0.leading.equalTo(view.snp.leading)
            $0.trailing.equalTo(view.snp.trailing)
            $0.top.greaterThanOrEqualTo(view.snp.top).offset(50)
        }
        
        verticalIcon.snp.makeConstraints {
            $0.top.greaterThanOrEqualTo(containerView.snp.top).offset(10)
            
            $0.leading.equalTo(containerView.snp.leading).offset(16)
            $0.trailing.equalTo(containerView.snp.trailing).offset(-16)
            
            $0.bottom.equalTo(containerView.snp.bottom).offset(-30)
        }
    }
    
    @objc private func createNewPetActionHandler() {
        let name = nameTextField.text ?? ""
        let age = ageTextField.text ?? ""
        
        presentLoader()
        viewModel.createPet(NewPet(name: name, age: age))
    }
    
    @objc private func closeActionHandler() {
        onCloseAction?()
    }
    
    func presentLoader() {
        loaderIndicator.startAnimating()
        loaderIndicator.isHidden = false
        addNewPetButton.setTitle("", for: .normal)
    }
    
    func hideLoader() {
        loaderIndicator.stopAnimating()
        loaderIndicator.isHidden = true
        addNewPetButton.setTitle("adicionar pet", for: .normal)
    }
}
