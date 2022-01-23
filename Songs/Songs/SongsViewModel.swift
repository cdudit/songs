//
//  SongsViewModel.swift
//  Songs
//
//  Created by Clément Dudit on 19/01/2022.
//

import SwiftUI

class SongsViewModel: ObservableObject {
    @Published var showAddSongView: Bool = false
    @Published var songs: [Song] = []
    @Published var selectedSong: Song? = nil
    
    init() {
        fetchSongs()
    }
    
    func getArtistLabel(for artist: Artist) -> String {
        return "\(artist.firstName ?? "") \(artist.lastName ?? "")"
    }
    
    func fetchSongs() {
        let songsResult = DBManager.shared.getAllSongs()
        switch songsResult {
        case .failure:              return
        case .success(let songs):   self.songs = songs
        }
    }
    
    func deleteSongs(at offsets: IndexSet) {
        offsets.forEach { index in
            DBManager.shared.deleteSong(by: songs[index].objectID)
        }
        songs.remove(atOffsets: offsets)
    }
}
