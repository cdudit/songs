//
//  SongDetailViewController.swift
//  Songs
//
//  Created by Clément Dudit on 19/01/2022.
//

import Foundation

class SongDetailViewModel: ObservableObject {
    @Published var song: Song?
    
    init() {

    }
}
