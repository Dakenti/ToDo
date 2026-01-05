//
//  ViewController.swift
//  ToDo
//
//  Created by darkhan on 05.01.2026.
//

import UIKit
import NetworkManager

final class ViewController: UIViewController {
    
    let client = URLSessionNetworkClient(
        baseURL: URL(string: "https://dummyjson.com/")!
    )

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red

        client.request(endpoint: TodosEndpoint(),
                       responseType: TodoItems.self) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let items):
                    print(items.todos)
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
}
