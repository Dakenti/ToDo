//
//  TodoItems.swift
//  ToDo
//
//  Created by darkhan on 05.01.2026.
//


import Foundation

public struct TodoItems: Decodable {

    public let todos: [TodoItem]?
}

extension TodoItems {

    public struct TodoItem: Decodable {
        
        public let id: Int?
        public let todo: String?
        public let completed: Bool?
        public let userId: Int?
        public var creationDate: Date?
        
        public var title: String { id.map { "#\($0)" } ?? "no title" }
    }
}
