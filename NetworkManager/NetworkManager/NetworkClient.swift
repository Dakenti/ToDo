//
//  NetworkClient.swift
//  NetworkManager
//
//  Created by darkhan on 05.01.2026.
//

public protocol NetworkClient {

    func request<T: Decodable>(
        endpoint: Endpoint,
        responseType: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void
    )
}
