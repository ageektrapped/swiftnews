//
//  NetworkManager.swift
//  SwiftNews
//
//  Created by JasonK on 2020-05-19.
//  Copyright © 2020 JasonKemp. All rights reserved.
//

import Foundation

class NetworkManager {
    enum NetworkError: Error {
        case unknown
    }
    
    static let session: URLSession = URLSession(configuration: .default)
    
    private var taskMap = [URL: URLSessionDataTask]()
    
    func fetch(_ url: URL?, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = url else { return }
        let dataTask = Self.session.dataTask(with: url) { [weak self] (data, response, error) in
            let result: Result<Data,Error>
            if let data = data {
                result = .success(data)
            } else if let error = error {
                result = .failure(error)
            } else {
                result = .failure(NetworkError.unknown)
            }
            completion(result)
            self?.taskMap.removeValue(forKey: url)
        }
        taskMap[url] = dataTask
        dataTask.resume()
    }
}
