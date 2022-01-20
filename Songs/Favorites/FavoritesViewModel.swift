//
//  FavoritesViewModel.swift
//  Songs
//
//  Created by Clément Dudit on 19/01/2022.
//

import SwiftUI

class FavoritesViewModel: ObservableObject {
    @Published var songs: [Song] = []

    init() {
        fetchFavoritesSongs()
    }
    
    func fetchFavoritesSongs() {
        let songsResults = DBManager.shared.getFavoritesSongs()
        switch songsResults {
        case .failure:              return
        case .success(let songs):   self.songs = songs
        }
    }
    
    func unfavoriteSong(for song: Song, index: Int) {
        DBManager.shared.unfavoriteSong(for: song)
        songs.remove(at: index)
    }
}
