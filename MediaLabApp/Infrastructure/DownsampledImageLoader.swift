//
//  ImageDownloader.swift
//  MediaLabApp
//
//  Created by Abraham Gonzalez Puga on 17/10/26.
//

import Foundation
import UIKit
import ImageIO

struct DownsampledImageLoader {

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func loadImage(
        from url: URL,
        maxPixelSize: Int
    ) async throws -> UIImage {

        guard maxPixelSize > 0 else {
            throw ImageLoadingError.invalidImageData
        }

        // 1. Download original image data
        let (data, response) = try await session.data(from: url)

        guard let httpResponse = response as? HTTPURLResponse,
              200..<300 ~= httpResponse.statusCode else {
            throw ImageLoadingError.invalidResponse
        }

        try Task.checkCancellation()

        // 2. Avoid decoding the full-size image
        let sourceOptions: [CFString: Any] = [
            kCGImageSourceShouldCache: false
        ]

        guard let source = CGImageSourceCreateWithData(
            data as CFData,
            sourceOptions as CFDictionary
        ) else {
            throw ImageLoadingError.invalidImageData
        }

        // 3. Create a smaller decoded image
        let thumbnailOptions: [CFString: Any] = [
            kCGImageSourceCreateThumbnailFromImageAlways: true,
            kCGImageSourceThumbnailMaxPixelSize: maxPixelSize,
            kCGImageSourceCreateThumbnailWithTransform: true,
            kCGImageSourceShouldCacheImmediately: true
        ]

        /*
        guard let thumbnail = CGImageSourceCreateThumbnailAtIndex(
            source,
            0,
            thumbnailOptions as CFDictionary
        ) else {
            throw ImageLoadingError.invalidImageData
        }

        // 4. Return the thumbnail
        return UIImage(cgImage: thumbnail)*/
        let thumbnail = try await ThumbnailProcessor.downsample(
            data: data,
            maxPixelSize: maxPixelSize
        )

        return UIImage(cgImage: thumbnail)
    }
}

