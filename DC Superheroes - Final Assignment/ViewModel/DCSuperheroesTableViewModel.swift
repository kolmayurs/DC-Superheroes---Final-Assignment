//
//  DCSuperheroesTableViewModal.swift
//  DC Superheroes - Final Assignment
//
//  Created by Mayur Koli on 06/01/23.
//

import Foundation

class DCSuperheroesTableViewModal{
    let title: String
    let likes: String
    let imageURL: URL?
    var imageData: Data? = nil
    
    init(title: String,
         likes: String,
         imageURL: URL?)
    {
        self.title = title
        self.likes = likes
        self.imageURL = imageURL
    }
}
