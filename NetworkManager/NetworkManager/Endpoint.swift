//
//  Endpoint.swift
//  NetworkManager
//
//  Created by darkhan on 05.01.2026.
//

import Foundation

public protocol Endpoint {

    var path: String { get }
    var method: HTTPMethod { get }
    var headers: [String: String]? { get }
    var queryItems: [URLQueryItem]? { get }
    var body: Data? { get }
}

public extension Endpoint {

    var headers: [String: String]? { ["Accept": "application/json"] }

    var queryItems: [URLQueryItem]? { nil }

    var body: Data? { nil }

    func makeRequest(baseURL: URL) throws -> URLRequest {
        let cleanPath = path.hasPrefix("/") ? String(path.dropFirst()) : path
        var components = URLComponents(
            url: baseURL.appendingPathComponent(path),
            resolvingAgainstBaseURL: false
        )
        
        components?.queryItems = queryItems

        guard let url = components?.url else {
            throw NetworkError.invalidURL
        }

        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        request.httpBody = method == .get ? nil : body
        request.allHTTPHeaderFields = headers
        request.timeoutInterval = 30
        request.cachePolicy = .reloadIgnoringLocalCacheData
        request.allowsCellularAccess = true

        return request
    }
}
