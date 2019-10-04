//
//  MovieSearch.swift
//  AnchorPoint3Assessment
//
//  Created by Josh Sparks on 10/4/19.
//  Copyright © 2019 Josh Sparks. All rights reserved.
//

import Foundation

struct TopLevelDict: Codable {
    let results: [MovieSearch]
}

struct MovieSearch: Codable {
    let id: Int
    let title: String
    let vote_average: Double
    let overview: String
    let poster_path: String
}

