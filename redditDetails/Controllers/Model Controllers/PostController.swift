//
//  PostController.swift
//  redditDetails
//
//  Created by Bryson Jones on 5/5/21.
//

import UIKit

class PostController {
    
    static func fetchPosts(completion: @escaping (Result<[Post], PostError>) -> Void) {
        
        //Saving just in case https://www.reddit.com/r/UFOs/.json
        let baseURL = URL(string: "https://www.reddit.com/user/Lingenfelter/m/ufo/.json")
        guard let finalURL = baseURL else {return completion(.failure(.invalidURL))}
        
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("POST STATUS CODE: \(response.statusCode)")
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            
            do {
                let topLevelObject = try JSONDecoder().decode(PostTopLevelObject.self, from: data)
                let secondLevelObject = topLevelObject.data
                let thirdLevelObject = secondLevelObject.children
                
                var arrayOfPosts: [Post] = []
                
                for j in thirdLevelObject {
                    let post = j.data
                    arrayOfPosts.append(post)
                }
                completion(.success(arrayOfPosts))
            } catch {
                completion(.failure(.thrownError(error)))
            }
        }.resume()
    }
    
    static func fetchThumbnail(post: Post, completion: @escaping (Result<UIImage, PostError>) -> Void) {
        
        guard let thumbnailURL = URL(string: post.thumbnail) else {return completion(.failure(.invalidURL))}
        
        URLSession.shared.dataTask(with: thumbnailURL) { data, response, error in
            
            if let error = error {
                return completion(.failure(.thrownError(error)))
            }
            
            if let response = response as? HTTPURLResponse {
                print("THUMBNAIL STATUS CODE: \(response.statusCode)")
            }
            
            guard let data = data else {return completion(.failure(.noData))}
            
            guard let thumbnail = UIImage(data: data) else {return completion(.failure(.unableToDecode))}
            completion(.success(thumbnail))
        }.resume()
    }
}//End of class
