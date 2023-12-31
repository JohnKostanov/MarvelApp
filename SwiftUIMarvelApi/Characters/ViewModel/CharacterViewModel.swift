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
                    RequestCharacter.fetchForStart(offset: self.offset, fetchedCharacters: self.fetched) { characters in
                        self.fetched = characters
                    }
                } else {
                    // search Data...
                    RequestCharacter.fetch(searchQuery: self.searchQuery, fetchedCharacters: self.fetched) { characters in
                        self.fetched = characters
                    }
                }
            })
    }
    
    override func fetch() {
        if searchQuery.isEmpty {
            RequestCharacter.fetchForStart(offset: self.offset, fetchedCharacters: fetched) { characters in
                self.fetched.append(contentsOf: characters)
            }
        }
    }
}
