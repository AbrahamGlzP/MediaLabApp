//
//  MediaLabApp.swift
//  MediaLabApp
//
//  Created by Abraham Gonzalez Puga on 14/10/26.
//

import SwiftUI
import CoreData

@main
struct MediaLabApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            GalleryFactory.createGallery()
        }
    }
}
