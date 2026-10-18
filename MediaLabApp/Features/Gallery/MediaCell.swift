//
//  MediaCell.swift
//  MediaLabApp
//
//  Created by Abraham Gonzalez Puga on 14/10/26.
//

import SwiftUI

struct MediaCell: View {
    
    private let item: MediaItem
    
    init(item: MediaItem) {
        self.item = item
    }
    
    var body: some View {
        VStack {
            VStack(alignment: .leading, spacing: 8) {

                NaiveRemoteImageView(url: item.imageURL)
                    .frame(height: 220)
                    .clipped()

                Text(item.author)
                    .font(.headline)

                Text("\(item.width) × \(item.height)")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
    }
}
