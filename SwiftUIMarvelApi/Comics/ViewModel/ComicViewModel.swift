//
//  ComicViewModel.swift
//  SwiftUIMarvelApi
//
//  Created by Джон Костанов on 17/3/22.
//

import SwiftUI

class ComicViewModel: ComicReader {
    
    override func fetchComics() {
        RequestComic.fetch(offset: offset, fetchedComics: &fetchedComics) { comics in
            self.fetchedComics.append(contentsOf: comics)
        }
    }
}
