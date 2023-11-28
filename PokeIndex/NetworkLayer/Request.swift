//
//  Request.swift
//  PokeIndex
//
//  Created by Ömer Ulusal on 28/11/2023.
//

import Foundation

protocol Request {
    associatedtype Response: Decodable
    
    var baseUrl: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    //var body
    //var header
    //var queryItems
}

enum HTTPMethod: String {
    case GET
}

extension Request {
    var asURLRequest: URLRequest {
        let url = URL(string: baseUrl + path)!
        let request = URLRequest(url: url)
        return request
    }
}
