//
//  CharactersView.swift
//  SwiftUIMarvelApi
//
//  Created by Джон Костанов on 22/2/22.
//

import SwiftUI

struct CharactersView: View {
    @EnvironmentObject var homeData: HomeViewModel
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    //Search bar ...
                    HStack(spacing: 10) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search Character", text: $homeData.searchQuery)
                            .autocapitalization(.none)
                            .disableAutocorrection(true)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal)
                    .background(.white)
                    .shadow(color: .black.opacity(0.06), radius: 5, x: 5, y: 5)
                    .shadow(color: .black.opacity(0.06), radius: 5, x: -5, y: -5)
                }
                .padding()
                if let characters = homeData.fetchedCharacters {
                    if characters.isEmpty {
                        // No results...
                        Text("No found results")
                            .padding(.top, 20)
                    } else {
                        // Displaying results
                        ForEach(characters) { data in
                            Text(data.name)
                        }
                    }
                } else {
                    if homeData.searchQuery != "" {
                        // Loading wait...
                        ProgressView()
                            .padding(.top, 20)
                    }
                   
                }
            }
            .navigationTitle("Marvel")
        }
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
