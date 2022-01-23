//
//  ArtistsView.swift
//  Songs
//
//  Created by Clément Dudit on 19/01/2022.
//

import SwiftUI

struct ArtistsView: View {
    @ObservedObject private var viewModel = ArtistsViewModel()
    @Binding var selected: Artist?

    @Environment(\.presentationMode) var mode: Binding<PresentationMode>
    
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
                        Text("\(artist.firstName ?? "") \(artist.lastName ?? "")").onTapGesture {
                            selected = artist
                            mode.wrappedValue.dismiss()
                        }
                    }.onDelete { offsets in
                        viewModel.deleteArtists(at: offsets)
                    }
                }
            }
            .listStyle(.insetGrouped)
            .animation(.easeInOut, value: viewModel.artists)
            .navigationBarHidden(true)
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
