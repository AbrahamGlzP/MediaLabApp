//
//  PicsumDTO.swift
//  MediaLabApp
//
//  Created by Abraham Gonzalez Puga on 14/10/26.
//

import Foundation

struct PicsumDTO: Decodable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let downloadURL: URL

    enum CodingKeys: String, CodingKey {
        case id
        case author
        case width
        case height
        case downloadURL = "download_url"
    }
}

extension PicsumDTO {
    func toDomain() -> MediaItem {
        MediaItem(
            id: id,
            author: author,
            width: width,
            height: height,
            imageURL: downloadURL
        )
    }
}
