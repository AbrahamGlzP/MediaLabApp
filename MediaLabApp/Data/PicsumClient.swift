//
//  PicsumData.swift
//  MediaLabApp
//
//  Created by Abraham Gonzalez Puga on 14/10/26.
//

import Foundation

struct PicsumClient {
    private let session: URLSession
    
    init(session: URLSession = .shared) {
        self.session = session
    }
    
    func fetchMedia(
        page: Int,
        limit: Int = 30
    ) async throws -> [PicsumDTO] {
        
        var components =  URLComponents(
            string: "https://picsum.photos/v2/list"
        )!
        
        components.queryItems = [
            URLQueryItem(name: "page", value: "\(page)"),
            URLQueryItem(name: "limit", value: "\(limit)")
        ]
        
        guard let url = components.url else {
            throw URLError(.badURL)
        }
        
        let (data, response) = try await session.data(from: url)
        
        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw URLError(.badServerResponse)
        }
        
        return try JSONDecoder().decode([PicsumDTO].self, from: data)
    }
}

