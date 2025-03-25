//
//  NetworkHelper.swift
//  DnDList
//
//  Created by Justin Snider on 3/21/25.
//

import Foundation

struct NetworkHelper {
    
    // MARK: - Static Functions
    
    static func performNetworkRequest(for url: URL) async -> Data? {
        let request = URLRequest(url: url)
        
        guard let (data, _) = try? await URLSession.shared.data(for: request) else {
            return nil
        }
        return data
    }
    
    static func performNetworkRequest<T: Decodable>(for url: URL, as type: T.Type = T.self) async -> T? {
        let request = URLRequest(url: url)
        
        guard let (data, _) = try? await URLSession.shared.data(for: request) else {
            return nil
        }
        return try? JSONDecoder().decode(T.self, from: data)
    }
}
