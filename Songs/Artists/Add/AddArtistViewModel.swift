//
//  AddArtistViewController.swift
//  Songs
//
//  Created by Clément Dudit on 19/01/2022.
//

import SwiftUI

class AddArtistViewModel: ObservableObject {
    @Published var firstName: String = ""
    @Published var lastName: String = ""

    func addArtist() {
        DBManager.shared.addArtist(
            firstName: firstName,
            lastName: lastName,
            coverURL: URL(string: "https://api.lorem.space/image/face?w=150&h=150")!,
            songs: []
        )
    }
    
    func canValidate() -> Bool {
        return !firstName.isEmpty && firstName != "" && !lastName.isEmpty && lastName != ""
    }
}
