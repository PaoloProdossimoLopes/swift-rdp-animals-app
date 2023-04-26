//
//  Moya+Endpoints.swift
//  Animals
//
//  Created by Paolo Prodossimo Lopes on 25/04/23.
//

import Moya
import Foundation

extension Endpoint: TargetType {
    var baseURL: URL { URL(string: "http://localhost:3000")! }
    
    var path: String {
        switch self {
        case .pets:
            return "/pets"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .pets(let request):
            return handleMethod(method: request.method)
        }
    }
    
    private func handleMethod(method: Method) -> Moya.Method {
        switch method {
        case .GET: return .get
        case .POST: return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .pets(let request):
            switch request.method {
            case .GET:
                return .requestPlain
            case .POST:
                return requestPetsWithParams(params: request.params)
            }
        }
    }
    
    private func requestPetsWithParams(params: [String: String]) ->  Moya.Task {
        let nome = params["name"]!
        let age = params["age"]!
        let url = "https://love.doghero.com.br/wp-content/uploads/2018/12/golden-retriever-1.png"
        let parameters = [
            "nome": nome,
            "age": age,
            "image-url": url
        ]
        return .requestParameters(
            parameters: parameters,
            encoding: JSONEncoding.default
        )
    }
    
    var headers: [String : String]? {
        ["Content-type": "application/json"]
    }
}

private extension String {
    var urlEscaped: String {
        addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)!
    }

    var utf8Encoded: Data { Data(self.utf8) }
}
