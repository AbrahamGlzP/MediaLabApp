//
//  GalleryViewModel.swift
//  MediaLabApp
//
//  Created by Abraham Gonzalez Puga on 14/10/26.
//

import Combine
import SwiftUI

@MainActor
@Observable
class GalleryViewModel {
    
    private(set) var items: [MediaItem] = []
    private(set) var isLoading = false
    private(set) var error: Error?
    
    private let repository: MediaRepository
    
    private var currentPage = 1
    
    init(repository: MediaRepository) {
        self.repository = repository
    }
    
    func loadInitialPage() async {
        guard items.isEmpty else {
            return
        }
        
        await loadNextPage()
    }
    
    func loadNextPage() async {
        
        guard !isLoading else {
            return
        }
        
        isLoading = true
        defer { isLoading = false }
        
        do {
            
            let newItems = try await repository.fetchPage(
                currentPage
            )
            
            items.append(contentsOf: newItems)
            currentPage += 1
            
        } catch {
            
            self.error = error
        }
    }
}
