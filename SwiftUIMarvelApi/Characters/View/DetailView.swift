//
//  DetailView.swift
//  SwiftUIMarvelApi
//
//  Created by Джон Костанов on 22/3/22.
//

import SwiftUI

struct DetailView: View {
    let data: RowProtocol
    
    var body: some View {
        VStack {
            ZStack {
                AsyncImage(url: URL(string: data.largeImagePath)) { image in
                    image.resizable()
                    image.scaledToFill()
                    image.aspectRatio(contentMode: .fill)
                } placeholder: {
                    ProgressView()
                }
                .frame(minHeight: 200, maxHeight: .infinity, alignment: .center)
                .clipped()
                .cornerRadius(8)
                
                Capsule()
                    .foregroundColor(.black.opacity(0.4))
                    .frame(width: 36, height: 5)
                    .padding(.top, 8)
            }
            ScrollView(.vertical, showsIndicators: true) {
                VStack(alignment: .leading, spacing: 0) {
                    if let name = data.name {
                        Text(name)
                            .font(.system(size: 24, weight: .bold))
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .center)
                    }
                    
                    if let comics = data.comics {
                        Text("Комиксов: \(comics.available)")
                            .padding(.bottom)
                            .font(.subheadline)
                    }
                    if let description = data.description {
                        Text(description.isEmpty ? "No description" : description)
                    }
                    
                    HStack(spacing: 10) {
                        ForEach(data.urls, id: \.self) { data in
                            NavigationLink(destination: WebView(url: self.data.extractURL(data: data))
                                            .navigationTitle(self.data.extractURLType(data: data)),
                                           label: {
                                Text(self.data.extractURLType(data: data))
                                
                            })
                        }
                    }
                }
                .padding(.horizontal)
            }
        }
        .background(
            VStack(spacing: 0) {
                if data.isImageExist {
                    AsyncImage(url: URL(string: data.largeImagePath)) { image in
                        image.blur(radius: 100)
                    } placeholder: {
                        ProgressView()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .overlay {
                        Color.white
                            .opacity(0.4)
                    }
                } else {
                    RadialGradient(gradient: Gradient(colors: [.red, .black]),
                                   center: .center,
                                   startRadius: 2,
                                   endRadius: 600)
                }
            }
        )
        .navigationBarTitleDisplayMode(.inline)
        .ignoresSafeArea(edges: [.bottom])
    }
}


struct DetailView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
