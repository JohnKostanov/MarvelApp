//
//  RequestProtocol.swift
//  SwiftUIMarvelApi
//
//  Created by Джон Костанов on 20/3/22.
//

import Foundation

protocol RequestProtocol {
    associatedtype APIResultData
    associatedtype Item
    associatedtype Settings
    
    static func createURL(query: Settings) -> String
    static func fetchData(url: String, completion: @escaping ([Item]) -> Void)
}
