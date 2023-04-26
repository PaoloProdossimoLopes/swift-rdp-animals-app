//
//  PetCellController.swift
//  Animals
//
//  Created by Paolo Prodossimo Lopes on 26/04/23.
//

import UIKit

final class PetCellController: NSObject, CellController {
    private let pet: Pet
    
    init(pet: Pet) {
        self.pet = pet
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fatalError("No use this")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellViewData = PetCell.ViewData(name: pet.name)
        let cell = tableView.reuse(for: PetCell.self, at: indexPath)
        cell.configure(cellViewData)
        cell.petImage.kf.setImage(with: URL(string: pet.imageURL))
        return cell
    }
}
