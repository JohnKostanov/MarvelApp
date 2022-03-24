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
                AsyncImage(url: URL(string: data.largeImagePath)) { phase in
                    if let image = phase.image {
                        image
                            .resizable()
                            .scaledToFit()
                    } else if phase.error != nil {
                        Text("There was an error loading the image.")
                    } else {
                        ProgressView()
                    }
                }
                .frame(minWidth: 200, idealWidth: 300, maxWidth: .infinity, minHeight: 400, idealHeight: 600, maxHeight: .infinity, alignment: .center)
                .cornerRadius(8)
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
                        Text("Comics: \(comics.available)")
                            .padding(.bottom)
                            .font(.title3)
                    }
                    if let description = data.description {
                        Text(description.isEmpty ? "No description" : description)
                    }
                    Spacer()
                    HStack(spacing: 10) {
                        ForEach(data.urls, id: \.self) { data in
                            NavigationLink {
                                WebView(url: self.data.extractURL(data: data))
                                    .navigationTitle(self.data.extractURLType(data: data))
                            } label: {
                                    Text(self.data.extractURLType(data: data))
                            }
                        }
                    }
                }
                .padding(.all)
                .padding(.bottom, 80)
            }
        }
        .background(
            VStack {
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
