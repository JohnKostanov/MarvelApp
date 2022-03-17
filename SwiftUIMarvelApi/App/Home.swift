//
//  Home.swift
//  SwiftUIMarvelApi
//
//  Created by Джон Костанов on 22/2/22.
//

import SwiftUI

struct Home: View {
    
    @StateObject var characterData = CharacterViewModel()
    @StateObject var comicData = ComicViewModel()
    
    var body: some View {
        TabView {
            CharactersView()
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Characters")
                }
            
            ComicsView()
                .tabItem {
                    Image(systemName: "books.vertical.fill")
                    Text("Comics")
                }
        }
        .environmentObject(characterData)
        .environmentObject(comicData)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
