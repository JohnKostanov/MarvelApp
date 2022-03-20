//
//  ComicViewModel.swift
//  SwiftUIMarvelApi
//
//  Created by Джон Костанов on 17/3/22.
//

import SwiftUI
import Combine

class ComicViewModel: ObservableObject {
    
    @Published var fetchedComics: [ComicProtocol] = []
    @Published var offset: Int = 0
    
    func fetchComics() {
        Request.fetchComics(offset: offset, fetchedComics: &fetchedComics) { comics in
            self.fetchedComics.append(contentsOf: comics)
        }
    }
}
