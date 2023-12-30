//
//  URLSession+Extensions.swift
//  
//
//  Created by John Scott on 29/12/2023.
//

import Foundation

extension URLSession {
    @available(iOS 15, macOS 12, *)
    func data<T: Decodable>(_ type: T.Type, for request: URLRequest, delegate: (URLSessionTaskDelegate)? = nil) async throws -> T {
        let result = try await data(for: request, delegate: delegate)
        let responseDecoder = URLResponseDecoder()
        return try responseDecoder.decode(T.self, from: result)
    }
}
