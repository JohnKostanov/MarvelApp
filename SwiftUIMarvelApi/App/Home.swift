//
//  Home.swift
//  SwiftUIMarvelApi
//
//  Created by Джон Костанов on 22/2/22.
//

import SwiftUI

struct Home: View {
    
    var body: some View {
        TabView {
            CharactersView(data: CharacterViewModel())
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Characters")
                }
            
            ComicsView(data: ComicViewModel())
                .tabItem {
                    Image(systemName: "books.vertical.fill")
                    Text("Comics")
                }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
