//
//  ChatacterProtocol.swift
//  SwiftUIMarvelApi
//
//  Created by Джон Костанов on 20/3/22.
//

import Foundation

protocol CharacterProtocol {
    var id: Int { get }
    var name: String { get }
    var description: String { get }
    var urls: [[String: String]] { get }
    var smallImagePath: String { get }
}
