//
//  Coorindator.swift
//  Animals
//
//  Created by Paolo Prodossimo Lopes on 25/04/23.
//

import UIKit

protocol Coorindator {
    var root: UIViewController { get }
    var childrens: [Coorindator] { get }
    func start()
}
