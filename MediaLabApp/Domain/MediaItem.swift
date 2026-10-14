//
//  MediaItmE.swift
//  MediaLabApp
//
//  Created by Abraham Gonzalez Puga on 14/10/26.
//

import Foundation

struct MediaItem: Identifiable, Sendable {
    let id: String
    let author: String
    let width: Int
    let height: Int
    let imageURL: URL
}
