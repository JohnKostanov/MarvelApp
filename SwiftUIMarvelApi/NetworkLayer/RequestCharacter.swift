//
//  Request.swift
//  SwiftUIMarvelApi
//
//  Created by Джон Костанов on 17/3/22.
//

import Foundation

struct RequestCharacter: RequestProtocol {
    
    typealias APIResultData = APIResult<APIData<Character>>
    typealias Item = CharacterProtocol
    typealias Settings = String
    
    static func createURL(query: Settings) -> String {
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(data: "\(ts)\(Marvel.privateKey)\(Marvel.publicKey)")
        let originalQuery = query.replacingOccurrences(of: " ", with: "%20")
        let url = "\(Marvel.serverURL)\(Marvel.requestCharacters)?nameStartsWith=\(originalQuery)&ts=\(ts)&apikey=\(Marvel.publicKey)&hash=\(hash)"
        
        return url
    }
    
    static func fetchData(url: String, completion: @escaping ([Item]) -> Void) {
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
                let decoded = try JSONDecoder().decode(APIResultData.self, from: dataAPI)
                DispatchQueue.main.async {
                    completion(decoded.data.results)
                }
            } catch {
                print(#line, error.localizedDescription)
                print(url)
            }
        }
        .resume()
    }
    
    static func fetch(searchQuery: String, fetchedCharacters: [Item], completion: @escaping ([CharacterProtocol]) -> Void) {
        
        let url = createURL(query: searchQuery)
        fetchData(url: url, completion: completion)
    }
}
