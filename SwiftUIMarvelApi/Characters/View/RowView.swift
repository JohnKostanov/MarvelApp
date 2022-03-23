//
//  CharacterRowView.swift
//  SwiftUIMarvelApi
//
//  Created by Джон Костанов on 3/3/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct RowView: View {
    let row: RowProtocol
    
    var body: some View {
        HStack(alignment: .top, spacing: 15) {
            WebImage(url: URL(string: row.smallImagePath))
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(width: 150, height: 150)
                .cornerRadius(8)
            
            VStack(alignment: .leading, spacing: 8) {
                if let name = row.name {
                    Text(name)
                        .font(.title3)
                        .fontWeight(.bold)
                }
                if let title = row.title {
                    Text(title)
                        .font(.title3)
                        .fontWeight(.bold)
                }
                if let description = row.description {
                    Text(description)
                        .font(.caption)
                        .foregroundColor(.gray)
                        .lineLimit(4)
                        .multilineTextAlignment(.leading)
                }
                
                
            }
            Spacer(minLength: 0)
        }
        .padding(.horizontal)
    }
}
