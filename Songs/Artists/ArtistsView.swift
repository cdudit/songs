//
//  ArtistsView.swift
//  Songs
//
//  Created by Clément Dudit on 19/01/2022.
//

import SwiftUI

struct ArtistsView: View {
    @ObservedObject private var viewModel = ArtistsViewModel()
    
    var body: some View {
        NavigationView {
            List {
                if viewModel.artists.isEmpty {
                    HStack {
                        Spacer()
                        Text("Add your first artist 🔥")
                        Spacer()
                    }
                } else {
                    ForEach(viewModel.artists) { artist in
                        Text("\(artist.firstName ?? "") \(artist.lastName ?? "")")
                    }.onDelete { offsets in
                        viewModel.deleteArtists(at: offsets)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .animation(.easeInOut, value: viewModel.artists)
        }
        .sheet(isPresented: $viewModel.showAddArtistView, onDismiss: {
            viewModel.fetchArtists()
        }) {
            AddArtistView()
        }
        .navigationTitle("Artists")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarItems(
            trailing:
                Button {
                    viewModel.showAddArtistView.toggle()
                } label: {
                    Image(systemName: "plus")
                }
        )
        .onAppear {
            viewModel.fetchArtists()
        }
    }
}
