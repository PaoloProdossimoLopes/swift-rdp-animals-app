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
    
    var coordinateToAddNewAnimal: (() -> Void)?
    
    private var viewModel: PetsViewModel
    private var petControllers = [CellController]() {
        didSet { tableView.reloadData() }
    }
    
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
        tableView.delegate = self
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
    
    init(viewModel: PetsViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { nil }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Pets"
        
        registerCells()
        
        configureStyle()
        configureHierarchy()
        configureConstraints()
        
        viewModel.onCompletesWithPets = { [weak self] pets in
            self?.petControllers = pets.map(PetCellController.init(pet:))
            self?.setLoading(false)
        }
        
        viewModel.onCompletesWithoutPets = { [weak self] in
            self?.petControllers = [WitoutPetCellController()]
            self?.setLoading(false)
        }
        
        viewModel.onCompleteWithFailure = { [weak self] in
            print("error")
            self?.setLoading(false)
        }
    }
    
    private func configureStyle() {
        view.backgroundColor = Theme.Color.gray800
    }
    
    private func registerCells() {
        tableView.register(PetCell.self)
        tableView.register(WitoutPetCell.self)
    }
    
    private func configureHierarchy() {
        verticalStack.addArrangedSubview(tableView)
        verticalStack.addArrangedSubview(addAnimalButton)
        view.addSubview(verticalStack)
        view.addSubview(loaderView)
    }
    
    private func configureConstraints() {
        
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
        viewModel.loadPets()
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

extension PetsViewController: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petControllers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return petControllers[indexPath.row].tableView(tableView, cellForRowAt: indexPath)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let height = petControllers[indexPath.row].tableView?(tableView, heightForRowAt: indexPath)
        return height ?? UITableView.automaticDimension
    }
}
