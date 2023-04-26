//
//  WitoutPetCellController.swift
//  Animals
//
//  Created by Paolo Prodossimo Lopes on 26/04/23.
//

import UIKit

final class WitoutPetCellController: NSObject, CellController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        fatalError("No use this")
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.reuse(for: WitoutPetCell.self, at: indexPath)
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.bounds.height
    }
}
