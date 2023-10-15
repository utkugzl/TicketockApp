//
//  Endpoints.swift
//  Ticketock
//
//  Created by Utku Güzel on 14.10.2023.
//

import Foundation

enum Endpoint {
    case getTrendingMovies
    case getPopularMovies
    case getTopRatedMovies
    
    var request: URLRequest? {
        guard let url = url else { return nil }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        return request
    }
    
    private var url: URL? {
        var components = URLComponents()
        components.scheme = AppConstants.scheme
        components.host = AppConstants.host
        components.path = path
        components.queryItems = [
            URLQueryItem(name: "api_key", value: AppConstants.API_KEY)
        ]
        return components.url
    }
    
    private var path: String {
        switch self {
        case .getTrendingMovies:
            return "/3/trending/movie/day"
        case .getPopularMovies:
            return "/3/movie/popular"
        case .getTopRatedMovies:
            return "/3/movie/top_rated"
        }
    }
    
    private var httpMethod: String {
        switch self {
        case .getTrendingMovies:
            return HTTP.Method.get.rawValue
        case .getPopularMovies:
            return HTTP.Method.get.rawValue
        case .getTopRatedMovies:
            return HTTP.Method.get.rawValue
        }
    }

}
