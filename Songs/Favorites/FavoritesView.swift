//
//  FavoritesView.swift
//  Songs
//
//  Created by Clément Dudit on 19/01/2022.
//

import SwiftUI

struct FavoritesView: View {
    @ObservedObject private var viewModel = FavoritesViewModel()

    var body: some View {
        NavigationView {
            List {
                if viewModel.songs.isEmpty {
                    HStack {
                        Spacer()
                        Text("Add your first favorite song 🔥")
                        Spacer()
                    }
                } else {
                    ForEach(viewModel.songs.indices) { index in
                        HStack {
                            let song = viewModel.songs[index]
                            if let title = song.title,
                               let artist = song.artist {
                                Text("\(title) by \(viewModel.getArtistLabel(for: artist))")
                                Spacer()
                                Image(systemName: "star.fill")
                                    .foregroundColor(.accentColor)
                                    .onTapGesture {
                                        viewModel.unfavoriteSong(for: song, index: index)
                                    }
                            }
                        }
                    }
                }
            }
            .listStyle(.insetGrouped)
            .animation(.easeInOut, value: viewModel.songs)
            .navigationTitle("Favorites")
            .onAppear {
                viewModel.fetchFavoritesSongs()
            }
        }
    }
}
