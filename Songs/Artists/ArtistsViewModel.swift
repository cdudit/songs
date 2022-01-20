//
//  ArtistsViewModel.swift
//  Songs
//
//  Created by Clément Dudit on 19/01/2022.
//

import SwiftUI

class ArtistsViewModel: ObservableObject {
    @Published var showAddArtistView: Bool = false
    @Published var artists: [Artist] = []

    init() {
        fetchArtists()
    }
    
    func fetchArtists() {
        let artistsResult = DBManager.shared.getAllArtists()
        switch artistsResult {
        case .failure:              return
        case .success(let artists): self.artists = artists
        }
    }
    
    func deleteArtists(at offsets: IndexSet) {
        offsets.forEach { index in
            DBManager.shared.deleteArtist(by: artists[index].objectID)
        }
        artists.remove(atOffsets: offsets)
    }
}
