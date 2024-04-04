//
//  NetworkManager.swift
//  AnimeList
//
//  Created by Nam Nguyễn on 04/04/2024.
//

import Foundation
import Combine

let BASE_URL = URL(string: "https://api.jikan.moe/v4")!

class NetworkManager {
    
    static let sharedInstance = NetworkManager()
    private init() {}
    
    func request<T: Decodable>(
        route: NetworkRouter,
        model: T.Type,
        completion: @escaping (Result<T, Error>) -> Void
    ) {

        let urlRequest = route.asURLRequest()
        let task = URLSession.shared.dataTask(with: urlRequest) { data, response, error in
            DispatchQueue.main.async {
                
                if let error = error {
                    completion(.failure(error))
                    return
                }

                guard let response = response as? HTTPURLResponse,
                      (200..<300).contains(response.statusCode) else {
                    completion(.failure(APIError.noData))
                    return
                }

                guard let data = data else {
                    completion(.failure(APIError.noData))
                    return
                }

                do {
                    let decoder = JSONDecoder()
                    let decodedObject = try decoder.decode(T.self, from: data)
                    completion(.success(decodedObject))
                } catch {
                    completion(.failure(APIError.decodingError(error: error)))
                }
            }
        }

        task.resume()
    }
}

enum APIError: Error {
    case networkError(error: Error)
    case decodingError(error: Error)
    case responseError(error: Error)
    case noData
}
