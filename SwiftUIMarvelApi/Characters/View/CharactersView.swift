//
//  CharactersView.swift
//  SwiftUIMarvelApi
//
//  Created by Джон Костанов on 22/2/22.
//

import SwiftUI

struct CharactersView: View {
    @ObservedObject var data: CharacterReader
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    //Search bar ...
                    HStack(spacing: 10) {
                        Image(systemName: "magnifyingglass")
                            .foregroundColor(.gray)
                        TextField("Search Character", text: $data.searchQuery)
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
                if let characters = data.fetched {
                  if !characters.isEmpty {
                        // Displaying results
                        ForEach(characters, id: \.id) { character in
                            NavigationLink {
                                DetailView(data: character)
                            } label: {
                                RowView(row: character)
                            }
                            
                        }
                    }
                    if data.offset == data.fetched.count && data.searchQuery.isEmpty {
                        ProgressView()
                            .padding(.vertical)
                            .onAppear {
                                print("fething new data")
                                data.fetch()
                            }
                    } else {
                        GeometryReader { reader -> Color in
                            let minY = reader.frame(in: .global).minY
                            let height = UIScreen.main.bounds.height / 1.3
                            
                            if !data.fetched.isEmpty && minY < height {
                                DispatchQueue.main.async {
                                    data.offset = data.fetched.count
                                }
                            }
                            return Color.clear
                        }
                        .frame(width: 20, height: 20)
                    }
                }
            }
            .navigationTitle("Marvel")
            .navigationBarTitleDisplayMode(.large)
        }
    }
}

struct CharactersView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

