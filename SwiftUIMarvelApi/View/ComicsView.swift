//
//  ComicsView.swift
//  SwiftUIMarvelApi
//
//  Created by Джон Костанов on 2/3/22.
//

import SwiftUI

struct ComicsView: View {
    @EnvironmentObject var homeData: HomeViewModel
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                if homeData.fetchedComics.isEmpty {
                    ProgressView()
                        .padding(.top, 30)
                } else {
                    // Displaying contents...
                    VStack(spacing: 15) {
                        ForEach(homeData.fetchedComics) { comic in
                            ComicRowView(comic: comic)
                        }
                        if homeData.offset == homeData.fetchedComics.count {
                            ProgressView()
                                .padding(.vertical)
                                .onAppear {
                                    print("fething new data")
                                    homeData.fetchComics()
                                }
                        } else {
                            GeometryReader { reader -> Color in
                                let minY = reader.frame(in: .global).minY
                                let height = UIScreen.main.bounds.height / 1.3
                                
                                if !homeData.fetchedComics.isEmpty && minY < height {
                                    DispatchQueue.main.async {
                                        homeData.offset = homeData.fetchedComics.count
                                    }
                                }
                                return Color.clear
                            }
                            .frame(width: 20, height: 20)
                        }
                    }
                    .padding(.vertical)
                }
            }
            .navigationTitle("Marvel's Comics")
        }
        .onAppear {
            if homeData.fetchedComics.isEmpty {
                homeData.fetchComics()
            }
        }
    }
}

struct ComicsView_Previews: PreviewProvider {
    static var previews: some View {
        ComicsView()
    }
}

