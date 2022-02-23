//
//  HomeViewModel.swift
//  SwiftUIMarvelApi
//
//  Created by Джон Костанов on 22/2/22.
//

import SwiftUI
import Combine

class HomeViewModel: ObservableObject {
    
    @Published var searchQuery = ""
    
    // Combine Framework Search Bar...
    // used to cancel the search publisher when ever we need...
    var searchCancellable: AnyCancellable? = nil
    
    init() {
        // since SwiftUI uses @published so its a publisher...
        // so we dont need to explicity define publisher...
        searchCancellable = $searchQuery
        // removing duplicate typings...
            .removeDuplicates()
            // we dont need to fetch for every typing.
            .debounce(for: 0.6, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str == "" {
                    // reset Data...
                } else {
                    // search Data...
                    print(str)
                }
            })
    }
}
