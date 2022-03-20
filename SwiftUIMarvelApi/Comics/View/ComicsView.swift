//
//  ComicsView.swift
//  SwiftUIMarvelApi
//
//  Created by Джон Костанов on 2/3/22.
//

import SwiftUI

struct ComicsView: View {
    @ObservedObject var data: ComicReader
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                if data.fetchedComics.isEmpty {
                    ProgressView()
                        .padding(.top, 30)
                } else {
                    // Displaying contents...
                    VStack(spacing: 15) {
                        ForEach(data.fetchedComics, id: \.id) { comic in
                            ComicRowView(comic: comic)
                        }
                        if data.offset == data.fetchedComics.count {
                            ProgressView()
                                .padding(.vertical)
                                .onAppear {
                                    print("fething new data")
                                    data.fetchComics()
                                }
                        } else {
                            GeometryReader { reader -> Color in
                                let minY = reader.frame(in: .global).minY
                                let height = UIScreen.main.bounds.height / 1.3
                                
                                if !data.fetchedComics.isEmpty && minY < height {
                                    DispatchQueue.main.async {
                                        data.offset = data.fetchedComics.count
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
            if data.fetchedComics.isEmpty {
                data.fetchComics()
            }
        }
    }
}

struct ComicsView_Previews: PreviewProvider {
    static var previews: some View {
        ComicsView(data: ComicViewModel())
    }
}

