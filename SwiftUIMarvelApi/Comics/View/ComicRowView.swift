//
//  ComicRowView.swift
//  SwiftUIMarvelApi
//
//  Created by Джон Костанов on 3/3/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct ComicRowView: View {
    let comic: ComicProtocol
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            WebImage(url: URL(string: comic.smallImagePath))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 8) {
                Text(comic.title)
                    .font(.title3)
                    .fontWeight(.bold)
                if let description = comic.description {
                    Text(description)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(4)
                        .multilineTextAlignment(.leading)
                }
                
                // Links
                HStack(spacing: 10) {
                    ForEach(comic.urls, id: \.self) { data in
                        NavigationLink(destination: WebView(url: extractURL(data: data))
                                        .navigationTitle(extractURLType(data: data)),
                                       label: {
                            Text(extractURLType(data: data))
                        })
                    }
                }
            }
            Spacer(minLength: 0)
        }
        .padding(.horizontal)
    }
    
    func extractURL(data: [String: String]) -> URL {
        let url = data["url"] ?? ""
        
        return URL(string: url)!
    }
    
    func extractURLType(data: [String: String]) -> String {
        let type = data["type"] ?? ""
        
        return type.capitalized
    }
}
