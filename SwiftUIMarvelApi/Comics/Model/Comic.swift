//
//  Comic.swift
//  SwiftUIMarvelApi
//
//  Created by Джон Костанов on 2/3/22.
//

struct APIComicResult: Codable {
    var data: APIComicData
}

struct APIComicData: Codable {
    var count: Int
    var results: [Comic]
}

struct Comic: Identifiable, Codable {
    var id: Int
    var title: String
    var description: String?
    var thumbnail: ImageURL
    var urls: [[String: String]]
    
    var smallImagePath: String {
        "\(thumbnail.path)/landscape_small.\(thumbnail.extension)"
    }
    
    struct ImageURL: Codable {
        let path: String
        let `extension`: String
    }
}
