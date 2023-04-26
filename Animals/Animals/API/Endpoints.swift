//
//  Endpoints.swift
//  Animals
//
//  Created by Paolo Prodossimo Lopes on 25/04/23.
//

import Foundation

enum Endpoint {
    case pets(Request)
}

struct Request {
    let method: Method
    var params: [String: String] = [:]
}

enum Method {
    case GET
    case POST
}
