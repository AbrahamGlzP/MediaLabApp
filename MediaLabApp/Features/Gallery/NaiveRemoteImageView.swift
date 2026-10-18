//
//  NaiveCell.swift
//  MediaLabApp
//
//  Created by Abraham Gonzalez Puga on 14/10/26.
//

import SwiftUI

struct NaiveRemoteImageView: View {

    let url: URL

    @State private var image: UIImage?
    @State private var isLoading = false

    // private let loader = NaiveImageLoader()
    private let loader = DownsampledImageLoader()

    @Environment(\.displayScale)
    private var displayScale
    
    var body: some View {
        Group {
            if let image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
            } else if isLoading {
                ProgressView()
            } else {
                Rectangle()
                    .fill(.secondary.opacity(0.2))
            }
        }
        .task(id: url) {
            await loadImage()
        }
    }

    private func loadImage() async {
        isLoading = true
        defer { isLoading = false }

        do {
            image = try await loader.load(from: url)
        } catch is CancellationError {
            return
        } catch {
            print("Image loading failed:", error)
        }
    }
}
