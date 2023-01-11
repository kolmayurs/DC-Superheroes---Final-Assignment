//
//  SuperHeroesModal.swift
//  DC Superheroes - Final Assignment
//
//  Created by Mayur Koli on 06/01/23.
//

struct APIResponse: Decodable{
    let dc: [SuperHeroes]
}

struct SuperHeroes: Decodable{
    let title: String
    let likeCount: Int?
    let imageUrl: String?
    
    private enum CodingKeys: String, CodingKey {
        case title = "name"
        case likeCount
        case imageUrl = "image_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        title = try container.decode(String.self, forKey: .title)
        likeCount = try container.decode(Int.self, forKey: .likeCount)
        imageUrl = try container.decode(String.self, forKey: .imageUrl)
    }
    
}
