//
//  GalleryView.swift
//  MediaLabApp
//
//  Created by Abraham Gonzalez Puga on 14/10/26.
//

import SwiftUI

struct GalleryView: View {
    
    @State private var viewModel: GalleryViewModel
    
    init(viewModel: GalleryViewModel) {
        _viewModel = State(initialValue: viewModel)
    }
    
    var body: some View {
        ScrollView(.vertical) {
            LazyVStack {
                ForEach(viewModel.items) { item in
                    MediaCell(item: item)
                }
                .padding(.bottom, 5)
            }
        }
        .task {
            await viewModel.loadInitialPage()
        }
    }
}
