//
//  HomeViewModel.swift
//  SwiftUIMarvelApi
//
//  Created by Джон Костанов on 22/2/22.
//

import SwiftUI
import Combine
import CryptoKit

class HomeViewModel: ObservableObject {
    
    @Published var searchQuery = ""
    
    // Combine Framework Search Bar...
    // used to cancel the search publisher when ever we need...
    var searchCancellable: AnyCancellable? = nil
    
    // Fetched Data...
    @Published var fetchedCharacters: [Character]? = nil
    @Published var fetchedComics: [Comic] = []
    @Published var offset: Int = 0
    
    init() {
        // since SwiftUI uses @published so its a publisher...
        // so we dont need to explicity define publisher...
        searchCancellable = $searchQuery
        // removing duplicate typings...
            .removeDuplicates()
        // we dont need to fetch for every typing.
            .debounce(for: 0.6, scheduler: RunLoop.main)
            .sink(receiveValue: { str in
                if str == "" {
                    // reset Data...
                    self.fetchedCharacters = nil
                } else {
                    // search Data...
                    self.searchHaracter()
                }
            })
    }
    
    func searchHaracter() {
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(data: "\(ts)\(Marvel.privateKey)\(Marvel.publicKey)")
        let originalQuery = searchQuery.replacingOccurrences(of: " ", with: "%20")
        let url = "\(Marvel.serverURL)\(Marvel.requestCharacters)?nameStartsWith=\(originalQuery)&ts=\(ts)&apikey=\(Marvel.publicKey)&hash=\(hash)"
        
        let session = URLSession(configuration: .default)
        
        guard let urlValid = URL(string: url) else {
            print(#line, "URL no valid" )
            return
        }
        
        session.dataTask(with: urlValid) { data, _, error in
            if let error = error {
                print(#line, error.localizedDescription)
                return
            }
            
            guard let dataAPI = data else {
                print(#line, "no data found")
                return
            }
            
            do {
                // Decoding Api data...
                let characters = try JSONDecoder().decode(APIResult.self, from: dataAPI)
                DispatchQueue.main.async {
                    if self.fetchedCharacters == nil {
                        self.fetchedCharacters = characters.data.results
                    }
                }
            } catch {
                print(#line, error.localizedDescription)
            }
        }
        .resume()
    }
    
    func fetchComics() {
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(data: "\(ts)\(Marvel.privateKey)\(Marvel.publicKey)")
        let url = "\(Marvel.serverURL)\(Marvel.requestComics)?limit=20&offset=\(offset)&ts=\(ts)&apikey=\(Marvel.publicKey)&hash=\(hash)"
        
        let session = URLSession(configuration: .default)
        
        guard let urlValid = URL(string: url) else {
            print(#line, "URL no valid" )
            return
        }
        
        session.dataTask(with: urlValid) { data, _, error in
            if let error = error {
                print(#line, error.localizedDescription)
                return
            }
            
            guard let dataAPI = data else {
                print(#line, "no data found")
                return
            }
            
            do {
                // Decoding Api data...
                let comics = try JSONDecoder().decode(APIComicResult.self, from: dataAPI)
                DispatchQueue.main.async {
                    self.fetchedComics.append(contentsOf: comics.data.results)
                }
            } catch {
                print(#line, error.localizedDescription)
                print(url)
            }
        }
        .resume()
    }
    
    // to generate hash were going  to use cryptoKit...
    func MD5(data: String) -> String {
        let hash = Insecure.MD5.hash(data: data.data(using: .utf8) ?? Data())
        
        return hash.map {
            String(format: "%02hhx", $0)
        }
        .joined()
    }
}
