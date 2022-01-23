//
//  SongsView.swift
//  Songs
//
//  Created by Clément Dudit on 19/01/2022.
//

import SwiftUI

struct SongsView: View {
    @ObservedObject private var viewModel = SongsViewModel()
    
    var body: some View {
        NavigationView {
            List {
                if viewModel.songs.isEmpty {
                    HStack {
                        Spacer()
                        Text("Add your first song 🔥")
                        Spacer()
                    }
                } else {
                    ForEach(viewModel.songs) { song in
                        HStack {
                            if let title = song.title,
                               let artist = song.artist {
                                Text(title)
                                Spacer()
                                Text(viewModel.getArtistLabel(for: artist))
                            }
                        }.onTapGesture {
                            viewModel.selectedSong = song
                        }
                    }.onDelete { offsets in
                        viewModel.deleteSongs(at: offsets)
                    }
                }
            }
            .sheet(item: $viewModel.selectedSong) { song in
                SongDetailView(song: song)
            }
            .listStyle(.insetGrouped)
            .animation(.easeInOut, value: viewModel.songs)
            .navigationTitle("Songs")
            .navigationBarItems(
                trailing:
                    Button {
                        viewModel.showAddSongView.toggle()
                    } label: {
                        Image(systemName: "plus")
                    }
            )
        }
        .sheet(isPresented: $viewModel.showAddSongView, onDismiss: {
            viewModel.fetchSongs()
        }) {
            AddSongView()
        }
        .onAppear {
            viewModel.fetchSongs()
        }
    }
}
