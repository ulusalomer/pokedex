//
//  APIClient.swift
//  PokeIndex
//
//  Created by Ömer Ulusal on 28/11/2023.
//

import Foundation

final class APIClient {
    static let shared = APIClient()
    
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    
    private init() {}
    
    func send<T: Request>(_ request: T) async -> T.Response {
        do {
            let (data, _) = try await URLSession.shared.data(for: request.asURLRequest)
            print(String.init(data: data, encoding: .utf8))
            return try decoder.decode(T.Response.self, from: data)
        } catch {
            fatalError()
        }
    }
}
