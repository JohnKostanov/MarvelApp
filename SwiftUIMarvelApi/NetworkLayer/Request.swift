//
//  Request.swift
//  SwiftUIMarvelApi
//
//  Created by Джон Костанов on 17/3/22.
//

import SwiftUI
import CryptoKit

class Request {
    
    static func createURLForSearch(searchQuery: String) -> String {
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(data: "\(ts)\(Marvel.privateKey)\(Marvel.publicKey)")
        let originalQuery = searchQuery.replacingOccurrences(of: " ", with: "%20")
        let url = "\(Marvel.serverURL)\(Marvel.requestCharacters)?nameStartsWith=\(originalQuery)&ts=\(ts)&apikey=\(Marvel.publicKey)&hash=\(hash)"
        
        return url
    }
    
    static func createURLForComics(offset: Int) -> String {
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(data: "\(ts)\(Marvel.privateKey)\(Marvel.publicKey)")
        let url = "\(Marvel.serverURL)\(Marvel.requestComics)?limit=20&offset=\(offset)&ts=\(ts)&apikey=\(Marvel.publicKey)&hash=\(hash)"
        
        return url
    }
    
    static func searchHaracter(searchQuery: String, fetchedCharacters: [Character], completion: @escaping ([Character]) -> Void) {
        
        let url = createURLForSearch(searchQuery: searchQuery)
        
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
                    if fetchedCharacters.isEmpty {
                        completion(characters.data.results)
                    }
                }
            } catch {
                print(#line, error.localizedDescription)
            }
        }
        .resume()
    }
    
    static func fetchComics(offset: Int, fetchedComics: inout [Comic], completion: @escaping ([Comic]) -> Void) {
       
        let url = createURLForComics(offset: offset)
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
                    completion(comics.data.results)
                }
            } catch {
                print(#line, error.localizedDescription)
                print(url)
            }
        }
        .resume()
    }
}

// to generate hash were going  to use cryptoKit...
func MD5(data: String) -> String {
    let hash = Insecure.MD5.hash(data: data.data(using: .utf8) ?? Data())
    
    return hash.map {
        String(format: "%02hhx", $0)
    }
    .joined()
}
