//
//  UserEndpoint.swift
//  ToDo
//
//  Created by darkhan on 05.01.2026.
//

import Foundation
import NetworkManager

public struct TodosEndpoint: Endpoint {

    public var path: String { "todos" }
    public var method: HTTPMethod { .get }
}
