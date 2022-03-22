//
//  ComicReader.swift
//  SwiftUIMarvelApi
//
//  Created by Джон Костанов on 20/3/22.
//

import SwiftUI
import Combine

class ComicReader: ObservableObject {
    
    @Published var fetched: [RowProtocol] = []
    @Published var offset: Int = 0
    
    func fetchComics() {
        
    }
}
