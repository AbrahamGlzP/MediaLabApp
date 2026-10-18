//
//  MediaRepository.swift
//  MediaLabApp
//
//  Created by Abraham Gonzalez Puga on 14/10/26.
//

import Foundation

struct MediaRepository {

    private let client: PicsumClient

    init(client: PicsumClient = PicsumClient()) {
        self.client = client
    }

    func fetchPage(
        _ page: Int
    ) async throws -> [MediaItem] {

        try await client
            .fetchMedia(page: page)
            .map { $0.toDomain() }
    }
}
