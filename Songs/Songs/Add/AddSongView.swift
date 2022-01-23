//
//  AddSongView.swift
//  Songs
//
//  Created by Clément Dudit on 19/01/2022.
//

import SwiftUI

struct AddSongView: View {
    @ObservedObject private var viewModel = AddSongViewModel()
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Title", text: $viewModel.songTitle)
                    DatePicker("Release date", selection: $viewModel.songDate, displayedComponents: .date)
                    RatingView(title: "Rate", rating: $viewModel.rate)
                } header: {
                    Text("Song")
                }
                
                Section {
                    NavigationLink(destination: ArtistsView(selected: $viewModel.selectedArtist)) {
                        Text("\(viewModel.selectedArtist?.firstName ?? "Pick an artist") \(viewModel.selectedArtist?.lastName ?? "")")
                    }
                } header: {
                    Text("Artist")
                }
                
                Section {
                    Toggle("Favorite song", isOn: $viewModel.isFavorite)
                        .toggleStyle(.automatic)
                        .tint(.accentColor)
                }
                
                Button() {
                    if viewModel.canValidate() {
                        viewModel.addSong()
                    }
                } label: {
                    HStack {
                        Spacer()
                        Text("Add song")
                        Spacer()
                    }
                }
                
            }
            .alert(viewModel.alertTitle, isPresented: $viewModel.showAlert, actions: {
                Button("OK", role: .cancel) {
                    presentationMode.wrappedValue.dismiss()
                }
            }, message: {
                Text(viewModel.alertMessage)
            })
            .navigationTitle("Add song")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
