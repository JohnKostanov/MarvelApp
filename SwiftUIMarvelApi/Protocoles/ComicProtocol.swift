//
//  ComicProtocol.swift
//  SwiftUIMarvelApi
//
//  Created by Джон Костанов on 20/3/22.
//

import Foundation

protocol ComicProtocol {
    var id: Int { get }
    var title: String { get }
    var description: String? { get }
    var urls: [[String: String]] { get }
    var smallImagePath: String  { get }
}
