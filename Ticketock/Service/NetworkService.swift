//
//  NetworkService.swift
//  Ticketock
//
//  Created by Utku Güzel on 14.10.2023.
//

import Foundation

class NetworkService {
    
    static let shared = NetworkService()
    private init() {}
    
    func getMovies(completion: @escaping (Result<Movie,Error>) -> Void) {
        request(.getTrendingMovies, completion: completion)
    }
    
    func getPopularMovies(completion: @escaping (Result<Movie,Error>) -> Void) {
        request(.getPopularMovies, completion: completion)
    }
    
    func getTopRatedMovies(completion: @escaping (Result<Movie,Error>) -> Void) {
        request(.getTopRatedMovies, completion: completion)
    }

    
    private func request<T: Decodable>(_ endpoint: Endpoint, completion: @escaping (Result<T,Error>) -> Void) {
        guard let request = endpoint.request else { fatalError("URL ERROR") }
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let response = response as? HTTPURLResponse , response.statusCode >= 200 , response.statusCode <= 299 else {
                completion(.failure(NSError(domain: "Invalid Response", code: 0)))
                
                return
            }

            guard let data = data else {
                completion(.failure(NSError(domain: "Invalid Response data", code: 0)))
                return
            }
            
            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            }catch let error {
                completion(.failure(error))
            }
                    
        }.resume()
            
    }
}
