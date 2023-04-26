//
//  MoyaRepostory.swift
//  Animals
//
//  Created by Paolo Prodossimo Lopes on 25/04/23.
//

import Foundation
import Moya

final class MoyaRepostory {
    let provider = MoyaProvider<Endpoint>()
    
    enum RepositoryError: Error {
        case decodeFails
        case receiveError(Error)
    }
}
