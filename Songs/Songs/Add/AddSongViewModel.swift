//
//  AddSongViewModel.swift
//  Songs
//
//  Created by Clément Dudit on 19/01/2022.
//

import SwiftUI

class AddSongViewModel: ObservableObject {
    @Published var songTitle: String = ""
    @Published var songDate = Date()
    @Published var rate: Int = 3
    @Published var isFavorite = false
    @Published var showAlert = false
    @Published var artists: [Artist] = []
    @Published var selectedArtist: Int = 0
    var alertMessage = ""
    var alertTitle = ""
    
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
    
    func addSong() {
        let songResult = DBManager.shared.addSong(
            title: songTitle,
            rate: Int64(rate),
            releaseDate: songDate,
            isFavorite: isFavorite,
            lyrics: "blablabla",
            coverURL: URL(string: "https://api.lorem.space/image/album")
        )
        
        switch songResult {
        case .success(let song):
            handleAlert(title: "Success", message: "\(song.title ?? "Song") added")
            
        case .failure(let error):
            handleAlert(title: "Error", message: error.localizedDescription)
        }
    }
    
    private func handleAlert(title: String, message: String) {
        alertTitle = title
        alertMessage = message
        showAlert.toggle()
    }
}
