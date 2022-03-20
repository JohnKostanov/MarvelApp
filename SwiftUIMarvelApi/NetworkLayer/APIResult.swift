//
//  APIResult.swift
//  SwiftUIMarvelApi
//
//  Created by Джон Костанов on 20/3/22.
//

struct APIResult<T: Codable>: Codable {
    var data: T
}

struct APIData<T: Codable>: Codable {
    var count: Int
    var results: [T]
}
