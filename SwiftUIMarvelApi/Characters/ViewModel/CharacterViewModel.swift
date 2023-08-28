//
//  CharacterViewModel.swift
//  SwiftUIMarvelApi
//
//  Created by Джон Костанов on 22/2/22.
//

import SwiftUI

class CharacterViewModel: CharacterReader {
    
    override init() {
        super.init()
        searchCancellable = $searchQuery
            .removeDuplicates()
            .debounce(for: 0.6, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str == "" {
                    // reset Data...
                    self.fetchedCharacters = []
                } else {
                    // search Data...
                    Request.searchHaracter(searchQuery: self.searchQuery, fetchedCharacters: self.fetchedCharacters) { characters in
                        self.fetchedCharacters = characters
                    }
                }
            })
    }
}
