//
//  GalleryFactory.swift
//  MediaLabApp
//
//  Created by Abraham Gonzalez Puga on 14/10/26.
//

class GalleryFactory {
    static func createGallery() -> GalleryView {
        let client = PicsumClient()
        let repository = MediaRepository(client: client)
        let viewModel = GalleryViewModel(repository: repository)
        return GalleryView(viewModel: viewModel)
    }
}
