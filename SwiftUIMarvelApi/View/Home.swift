//
//  Home.swift
//  SwiftUIMarvelApi
//
//  Created by Джон Костанов on 22/2/22.
//

import SwiftUI

struct Home: View {
    
    @StateObject var homeData = HomeViewModel()
    
    var body: some View {
        TabView {
            CharactersView()
                .tabItem {
                    Image(systemName: "person.3.fill")
                    Text("Characters")
                }
                .environmentObject(homeData)
            
            ComicsView()
                .tabItem {
                    Image(systemName: "books.vertical.fill")
                    Text("Comics")
                }
                .environmentObject(homeData)
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
