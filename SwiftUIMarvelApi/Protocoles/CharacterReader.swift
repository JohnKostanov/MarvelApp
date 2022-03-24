//
//  CharacterReader.swift
//  SwiftUIMarvelApi
//
//  Created by Джон Костанов on 20/3/22.
//

import SwiftUI
import Combine

class CharacterReader: ObservableObject {
    
    @Published var searchQuery = ""
    @Published var offset: Int = 0
    
    var searchCancellable: AnyCancellable? = nil
    
    @Published var fetched: [RowProtocol] = []
    
    func fetch() {
        // Override
    }
}
