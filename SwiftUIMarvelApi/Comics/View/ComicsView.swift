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
                if data.fetched.isEmpty {
                    ProgressView()
                        .padding(.top, 30)
                } else {
                    // Displaying contents...
                    VStack(spacing: 15) {
                        ForEach(data.fetched, id: \.id) { comic in
                            RowView(row: comic)
                        }
                        if data.offset == data.fetched.count {
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
                    .padding(.vertical)
                }
            }
            .navigationTitle("Marvel's Comics")
        }
        .onAppear {
            if data.fetched.isEmpty {
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

