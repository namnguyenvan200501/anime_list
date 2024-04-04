//
//  URLRequest+HTTPMethod.swift
//  AnimeList
//
//  Created by Nam Nguyễn on 05/04/2024.
//

import Foundation

extension URLRequest {
    
    enum HTTPMethod: String {
        case get = "GET"
    }
    
    var method: HTTPMethod? {
        get { HTTPMethod(rawValue: self.httpMethod ?? "") }
        set { self.httpMethod = newValue?.rawValue ?? ""}
    }
}
