//
//  Marvel.swift
//  SwiftUIMarvelApi
//
//  Created by Джон Костанов on 22/2/22.
//

import Foundation
import CryptoKit

enum Marvel {
    static let serverURL = "https://gateway.marvel.com:443"
    static let requestCharacters = "/v1/public/characters"
    static let requestComics = "/v1/public/comics"
    static let publicKey = "8a25e7de8f200adbf25f7e6c613c882c"
    static let privateKey = "88c6eb42c20706dba7903a39b8496f65fa1c6359"
}

func MD5(data: String) -> String {
    let hash = Insecure.MD5.hash(data: data.data(using: .utf8) ?? Data())
    
    return hash.map {
        String(format: "%02hhx", $0)
    }
    .joined()
}
