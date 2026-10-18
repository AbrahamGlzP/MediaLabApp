//
//  NaiveImageLoader.swift
//  MediaLabApp
//
//  Created by Abraham Gonzalez Puga on 14/10/26.
//

import Foundation
import SwiftUI

struct NaiveImageLoader {

    func load(
        from url: URL
    ) async throws -> UIImage {

        let (data, _) = try await URLSession.shared.data(from: url)

        guard let image = UIImage(data: data) else {
            throw ImageLoadingError.invalidData
        }

        return image
    }
}
