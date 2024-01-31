//
//  ProductModel.swift
//  Products MVVM
//
//  Created by Prashantdan on 20/01/24.
//

import Foundation
//import QuartzCore

struct Product: Codable{
    let id: Int
    let title: String
    let price: Double
    let description: String
    let category: String
    let image: String
    let rating: Rate
    
    /*enum Codingkeys: String, CodingKey {
        case id = "id"
        case title = "title"
        case price = "price"
        case description = "description"
        case category = "category"
        case image = "image"
        case rating = "rating"
    }*/
}


struct Rate: Codable{
    let rate: Double
    let count: Int
    
    /*enum Codingkeys: String, CodingKey {
        case rate = "rate"
        case count = "count"
    }*/
}
