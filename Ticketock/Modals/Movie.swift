//
//  Movie.swift
//  Ticketock
//
//  Created by Utku Güzel on 14.10.2023.
//

import Foundation

// MARK: - Welcome
struct Movie: Codable {
    let results: [MovieDetails]
}

// MARK: - Result
struct MovieDetails: Codable {
    let backdropPath: String
    let id: Int
    let title: String
    let originalTitle, overview, posterPath: String
    let popularity: Double
    let releaseDate: String
    let video: Bool
    let voteAverage: Double
    let voteCount: Int
    
    enum CodingKeys: String, CodingKey {
        case backdropPath = "backdrop_path"
        case id, title
        case originalTitle = "original_title"
        case overview
        case posterPath = "poster_path"
        case popularity
        case releaseDate = "release_date"
        case video
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}


