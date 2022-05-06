//
//  RandomUsersDTO.swift
//  InfiniteScroll PullToRefresh Paging
//
//  Created by Bilal on 6.05.2022.
//

// This file was generated from JSON Schema using quicktype, do not modify it directly.
// To parse the JSON, add this file to your project and do:
//
//   let randomUser = try? newJSONDecoder().decode(RandomUser.self, from: jsonData)

import Foundation

// MARK: - RandomUser
struct RandomUsersDTO: Codable {
    let results: [Result]
    let info: Info
}

// MARK: - Info
struct Info: Codable {
    let seed: String
    let results, page: Int
    let version: String
}

// MARK: - Result
struct Result: Codable {
    let name: Name
    let location: Location
    let email: String
    let picture: Picture
}



// MARK: - Location
struct Location: Codable {
    let street: Street
    let city, state, country: String
}

// MARK: - Street
struct Street: Codable {
    let number: Int
    let name: String
}


// MARK: - Name
struct Name: Codable {
    let title, first, last: String
}

// MARK: - Picture
struct Picture: Codable {
    let large, medium, thumbnail: String
}

