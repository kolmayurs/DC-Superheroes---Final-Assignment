//
//  APICaller.swift
//  DC Superheroes - Final Assignment
//
//  Created by Mayur Koli on 03/01/23.
//

import Foundation

final class APICaller{
    static let shared = APICaller()
    
    struct Constants {
        static let dcSuperHerosURL = URL(string: "https://demo2782755.mockable.io/superheroes")
    }
    
    public func getDCSuperHeroesData(completion: @escaping(Result<[SuperHeroes],Error>) -> Void){
        guard let url = Constants.dcSuperHerosURL else {
            return
        }
        let task = URLSession.shared.dataTask(with: url) { data, _, error in
            if let error = error{
                completion(.failure(error))
            }
            else if let data = data {
                do{
                    let result = try JSONDecoder().decode(APIResponse.self, from: data)
                    completion(.success(result.dc))
                }
                catch{
                    completion(.failure(error))
                }
            }
        }
        task.resume()
    }
}


