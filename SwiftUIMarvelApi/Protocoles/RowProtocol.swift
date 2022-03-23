//
//  RowProtocol.swift
//  SwiftUIMarvelApi
//
//  Created by Джон Костанов on 20/3/22.
//

import Foundation

protocol RowProtocol {
    var id: Int { get }
    var name: String? { get }
    var title: String? { get }
    var description: String? { get }
    var urls: [[String: String]] { get }
    var thumbnail: ImageURL { get }
    var comics: Comics? { get }
}

extension RowProtocol {
    var smallImagePath: String {
        "\(thumbnail.path)/landscape_small.\(thumbnail.extension)"
    }
    
    var largeImagePath: String {
        "\(thumbnail.path)/detail.\(thumbnail.extension)"
    }
    
    var isImageExist: Bool {
        !thumbnail.path.contains("image_not_available")
    }
    
    func extractURL(data: [String: String]) -> URL {
        let url = data["url"] ?? ""
        
        return URL(string: url)!
    }
    
    func extractURLType(data: [String: String]) -> String {
        let type = data["type"] ?? ""
        
        return type.capitalized
    }
}
