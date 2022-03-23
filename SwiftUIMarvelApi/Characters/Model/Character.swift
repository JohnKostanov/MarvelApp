//
//  Character.swift
//  SwiftUIMarvelApi
//
//  Created by Джон Костанов on 1/3/22.
//

struct Character: RowProtocol, Codable, Identifiable {
    var id: Int
    var name: String?
    var title: String?
    var description: String?
    var thumbnail: ImageURL
    var comics: Comics?
    var urls: [[String: String]]
}

struct ImageURL: Codable {
    let path: String
    let `extension`: String
}

struct Comics: Codable {
    let available: Int
}
