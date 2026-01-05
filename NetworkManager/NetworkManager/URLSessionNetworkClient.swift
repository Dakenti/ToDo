//
//  URLSessionNetworkClient.swift
//  NetworkManager
//
//  Created by darkhan on 05.01.2026.
//

import Foundation

public final class URLSessionNetworkClient: NetworkClient {

    private let baseURL: URL
    private let session: URLSession
    private let decoder: JSONDecoder

    public init(
        baseURL: URL,
        session: URLSession = .shared,
        decoder: JSONDecoder = JSONDecoder()
    ) {
        self.baseURL = baseURL
        self.session = session
        self.decoder = decoder
    }

    public func request<T: Decodable>(
        endpoint: Endpoint,
        responseType: T.Type,
        completion: @escaping (Result<T, NetworkError>) -> Void
    ) {

        let request: URLRequest
        do {
            request = try endpoint.makeRequest(baseURL: baseURL)
        } catch {
            completion(.failure(error as? NetworkError ?? .invalidURL))
            return
        }

        session.dataTask(with: request) { [weak self] data, response, error in

            if let error = error {
                completion(.failure(.underlying(error)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.invalidResponse))
                return
            }

            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(.statusCode(httpResponse.statusCode)))
                return
            }

            guard let data = data, !data.isEmpty else {
                completion(.failure(.emptyData))
                return
            }

            guard let self = self else { return }

            do {
                let decoded = try self.decoder.decode(T.self, from: data)
                completion(.success(decoded))
            } catch {
                completion(.failure(.decoding(error)))
            }

        }.resume()
    }
}
