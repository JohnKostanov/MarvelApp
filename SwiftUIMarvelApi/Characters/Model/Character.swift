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
    var urls: [[String: String]]
    
    var smallImagePath: String {
        "\(thumbnail.path)/landscape_small.\(thumbnail.extension)"
    }
    
    struct ImageURL: Codable {
        let path: String
        let `extension`: String
    }
}
