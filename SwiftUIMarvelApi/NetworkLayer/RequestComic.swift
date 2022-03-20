//
//  RequestComic.swift
//  SwiftUIMarvelApi
//
//  Created by Джон Костанов on 20/3/22.
//

import Foundation

class RequestComic: RequestProtocol {
    
    typealias APIResultData = APIResult<APIData<Comic>>
    typealias Item = ComicProtocol
    typealias Settings = Int
    
    static func createURL(query: Settings) -> String {
        let ts = String(Date().timeIntervalSince1970)
        let hash = MD5(data: "\(ts)\(Marvel.privateKey)\(Marvel.publicKey)")
        let url = "\(Marvel.serverURL)\(Marvel.requestComics)?limit=20&offset=\(query)&ts=\(ts)&apikey=\(Marvel.publicKey)&hash=\(hash)"
        
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
    
    static func fetch(offset: Int, fetchedComics: inout [ComicProtocol], completion: @escaping ([ComicProtocol]) -> Void) {
        let url = createURL(query: offset)
        fetchData(url: url, completion: completion)
    }
}

