//
//  ThumbnailProcessor.swift
//  MediaLabApp
//
//  Created by Abraham Gonzalez Puga on 18/10/26.
//


import Foundation
import ImageIO

enum ThumbnailProcessor {

    @concurrent
    static func downsample(
        data: Data,
        maxPixelSize: Int
    ) async throws -> CGImage {

        try Task.checkCancellation()

        guard maxPixelSize > 0 else {
            throw URLError(.cannotDecodeContentData)
        }

        let sourceOptions: [CFString: Any] = [
            kCGImageSourceShouldCache: false
        ]

        guard let source = CGImageSourceCreateWithData(
            data as CFData,
            sourceOptions as CFDictionary
        ) else {
            throw URLError(.cannotDecodeContentData)
        }

        let thumbnailOptions: [CFString: Any] = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceThumbnailMaxPixelSize: maxPixelSize,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceShouldCacheImmediately: true
        ]

        guard let thumbnail = CGImageSourceCreateThumbnailAtIndex(
            source,
            0,
            thumbnailOptions as CFDictionary
        ) else {
            throw URLError(.cannotDecodeContentData)
        }

        try Task.checkCancellation()

        return thumbnail
    }
}
