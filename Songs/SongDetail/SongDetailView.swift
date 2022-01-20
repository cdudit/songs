//
//  SongDetailView.swift
//  Songs
//
//  Created by Clément Dudit on 19/01/2022.
//

import SwiftUI

struct SongDetailView: View {
    @ObservedObject private var viewModel = SongDetailViewModel()
    @State var song: Song
    
    var body: some View {
        NavigationView {
            List {
                Section(header: Text("Song")) {
                    HStack {
                        Text("Title")
                        Spacer()
                        Text(song.title ?? "")
                    }
                    HStack {
                        Text("Release date")
                        Spacer()
                        Text(song.releaseDate ?? Date(), style: .date)
                    }
                    HStack {
                        Text("Rating")
                        Spacer()
                        Text("\(String(song.rate))/5")
                    }
                }
                
                Section(header: Text("Artist")) {
                    HStack {
                        Text("Fist name")
                        Spacer()
                        Text(song.artist?.firstName ?? "")
                    }
                    HStack {
                        Text("Last name")
                        Spacer()
                        Text(song.artist?.lastName ?? "")
                    }
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(song.title ?? "")
        }
    }
}
