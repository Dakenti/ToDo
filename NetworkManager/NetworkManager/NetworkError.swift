//
//  NetworkError.swift
//  NetworkManager
//
//  Created by darkhan on 05.01.2026.
//


public enum NetworkError: Error {

    case invalidURL
    case invalidResponse
    case statusCode(Int)
    case emptyData
    case decoding(Error)
    case underlying(Error)
}
