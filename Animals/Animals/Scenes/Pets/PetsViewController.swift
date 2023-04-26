//
//  PetsViewController.swift
//  Animals
//
//  Created by Paolo Prodossimo Lopes on 25/04/23.
//

import UIKit
import Foundation
import Kingfisher
import Lottie

final class PetsViewController: UIViewController {
    
    private var pets = [Pet]()
    private let repository: PetsRepositoryProvider
    var coordinateToAddNewAnimal: (() -> Void)?
    
    private lazy var loaderView: LottieAnimationView = {
        let av = LottieAnimationView(name: "lootie-pet-loadier")
        av.contentMode = .scaleAspectFit
        av.loopMode = .loop
        av.animationSpeed = 2
        return av
    }()
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.backgroundColor = Theme.Color.gray800
        tableView.separatorStyle = .none
        return tableView
    }()
    
    private lazy var addAnimalButton: UIButton = {
        let button = UIButton()
        button.setTitle("add novo pet", for: .normal)
        button.backgroundColor = Theme.Color.green500
        button.setTitleColor(Theme.Color.white, for: .normal)
        button.layer.cornerRadius = 20
        button.addTarget(self, action: #selector(addNewAnimalActionHandler), for: .touchUpInside)
        return button
    }()
    
    private var verticalStack: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 20
        stack.backgroundColor = Theme.Color.gray800
        return stack
    }()
    
    init(repository: PetsRepositoryProvider) {
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pets"
        view.backgroundColor = Theme.Color.gray800
        
        tableView.register(PetCell.self)
        
        verticalStack.addArrangedSubview(tableView)
        verticalStack.addArrangedSubview(addAnimalButton)
        view.addSubview(verticalStack)
        view.addSubview(loaderView)
        
        addAnimalButton.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        
        loaderView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.height.width.equalTo(80)
        }
        
        verticalStack.snp.makeConstraints {
            $0.top.equalTo(view.snp.top).offset(0)
            $0.leading.equalTo(view.snp.leading).offset(16)
            $0.trailing.equalTo(view.snp.trailing).offset(-16)
            $0.bottom.equalTo(view.snp.bottom).offset(-30)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setLoading(true)
        repository.loadPets { [weak self] result in
            guard let self else { return }
            switch result {
            case .success(let receivedPets):
                self.pets = receivedPets
                self.tableView.reloadData()
            case .failure(let error):
                print("Error:", error.localizedDescription)
            }

            self.setLoading(false)
        }
    }
    
    private func setLoading(_ isLoading: Bool) {
        loaderView.play()
        loaderView.isHidden = !isLoading
        verticalStack.isHidden = isLoading
    }
    
    @objc private func addNewAnimalActionHandler() {
        coordinateToAddNewAnimal?()
    }
}

extension PetsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return pets.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.reuse(for: PetCell.self, at: indexPath)
        
        let pet = pets[indexPath.row]
        let cellViewData = PetCell.ViewData(name: pet.name)
        cell.configure(cellViewData)
        cell.petImage.kf.setImage(with: URL(string: pet.imageURL))
        return cell
    }
}
