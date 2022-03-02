//
//  Character.swift
//  SwiftUIMarvelApi
//
//  Created by Джон Костанов on 1/3/22.
//


// Model
struct APIResult: Codable {
    var data: APICharacterData
}

struct APICharacterData: Codable {
    var count: Int
    var results: [Character]
}

struct Character: Identifiable, Codable {
    var id: Int
    var name: String
    var description: String
    var thumbnail: [String: String]
    var urls: [[String: String]]
}
