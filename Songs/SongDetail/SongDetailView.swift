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
    
    init(song: Song) {
        self.song = song
        viewModel.image = viewModel.getImage(song: song)
        UINavigationBar.appearance().backgroundColor = viewModel.getAverageUIColor() ?? UIColor()
    }
    
    var body: some View {
        NavigationView {
            VStack {
                Image(uiImage: viewModel.image)
                    .resizable()
                    .frame(width:100, height:100)
                    .scaledToFill()
                    .clipShape(Circle())
                    .padding(.top, 20)
                List {
                    Section(header: Text("Song").foregroundColor(viewModel.getColor())) {
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
                    
                    Section(header: Text("Artist").foregroundColor(viewModel.getColor())) {
                        HStack {
                            Text("First name")
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
            }
            .navigationBarTitleDisplayMode(.inline)
            .navigationTitle(song.title ?? "")
        }.onDisappear {
            UINavigationBar.appearance().backgroundColor = nil
        }
    }
}
