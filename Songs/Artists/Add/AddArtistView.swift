//
//  AddArtistView.swift
//  Songs
//
//  Created by Clément Dudit on 19/01/2022.
//

import SwiftUI

struct AddArtistView: View {
    @ObservedObject private var viewModel = AddArtistViewModel()
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("First name", text: $viewModel.firstName)
                    TextField("Last name", text: $viewModel.lastName)
                }
                
                Button {
                    if viewModel.canValidate() {
                        viewModel.addArtist()
                        presentationMode.wrappedValue.dismiss()
                    }
                } label: {
                    HStack {
                        Spacer()
                        Text("Add artist")
                        Spacer()
                    }
                }
            }
            .navigationTitle("Add artist")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}
