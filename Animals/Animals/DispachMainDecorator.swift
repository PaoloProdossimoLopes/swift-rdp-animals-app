//
//  DispachMainDecorator.swift
//  Animals
//
//  Created by Paolo Prodossimo Lopes on 25/04/23.
//

import Foundation

final class DispachMainDecorator<T: AnyObject> {
    let dispatcher = DispatchQueue.main
    let decoratee: T
    
    init(_ decoratee: T) {
        self.decoratee = decoratee
    }
}
