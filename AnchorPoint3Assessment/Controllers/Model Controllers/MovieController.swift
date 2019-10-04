//
//  MovieController.swift
//  AnchorPoint3Assessment
//
//  Created by Josh Sparks on 10/4/19.
//  Copyright © 2019 Josh Sparks. All rights reserved.
//

import Foundation
import UIKit

class MovieController {
    
    static var baseURL = URL(string: "https://api.themoviedb.org")
    static var imageBaseURL = URL(string: "https://image.tmdb.org/t/p/w500")
    
    static func fetchMovie(searchText: String, completion: @escaping(([MovieSearch]) -> Void)) {
        guard let unwrappedURL = self.baseURL else {completion([]); return }
        let versionComponentURL = unwrappedURL.appendingPathComponent("3")
        let searchComponentURL = versionComponentURL.appendingPathComponent("search")
        let movieComponentURL = searchComponentURL.appendingPathComponent("movie")
        guard var components = URLComponents(url: movieComponentURL, resolvingAgainstBaseURL: true) else {completion([]); return}
        
        let apiKeyQueryItem = URLQueryItem(name: "api_key", value: "626d672a0da2861da16a3f9f5cf499ff")
        let movieQueryItem = URLQueryItem(name: "query", value: searchText)
        
        
        
        components.queryItems = [apiKeyQueryItem, movieQueryItem]
        
        guard let finalURL = components.url else {
            print("Components have an issue")
            completion([])
            return
        }
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print("error retrieving the info from TMDb \(error.localizedDescription)")
                completion([])
                return
            }
            guard let data = data else {
                print("no data wa received")
                completion([])
                return
            }
            
            let jsonDecoder = JSONDecoder()
            do {
                let topLevelDict = try jsonDecoder.decode(TopLevelDict.self, from: data)
                completion(topLevelDict.results)
            } catch {
                print("error decoding data")
            }
        } .resume()
    }
    
    static func fetchImage(item: MovieSearch, completion: @escaping (UIImage?) -> Void) {
        guard let unwrappedURL = self.imageBaseURL else { return }
        let posterComponent = unwrappedURL.appendingPathComponent(item.poster_path)
        
        guard let components = URLComponents(url: posterComponent, resolvingAgainstBaseURL: true) else {completion(nil); return}
        
        guard let finalURL = components.url else {
            print("Image components have an issue")
            completion(nil)
            return
        }
        URLSession.shared.dataTask(with: finalURL) { (data, _, error) in
            if let error = error {
                print(error.localizedDescription)
                completion(nil)
                return
            }
            guard let data = data else {
                print("Could not retrieve image data")
                completion(nil)
                return
            }
            let image = UIImage(data: data)
            completion(image)
            } .resume()
    }
} // end of class
