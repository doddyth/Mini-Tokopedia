//
//  ShopResponse.swift
//  Mini-Tokopedia
//
//  Created by Doddy Tri Hutomo on 30/04/18.
//  Copyright © 2018 Doddy. All rights reserved.
//

import Foundation

struct ShopResponse: Codable {
    let id: String?
    let name: String?
    let URL: String?
    let isGold: Bool?
    let rating: Int?
    let location: String?
    let reputationImageURL: String?
    let shopLucky: String?
    let city: String?
    
    fileprivate enum ShopKeys:String, CodingKey {
        case id
        case name
        case URL = "uri"
        case isGold = "is_gold"
        case rating
        case location
        case reputationImageURL = "reputation_image_uri"
        case shopLucky = "shop_lucky"
        case city
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ShopKeys.self)
        self.id = String(try container.decode(Int.self, forKey: .id))
        self.name = try container.decode(String.self, forKey: .name)
        self.URL = try container.decode(String.self, forKey: .URL)
        self.isGold = Bool(truncating: try container.decode(Int.self, forKey: .isGold) as NSNumber)
        self.rating = try container.decodeIfPresent(Int.self, forKey: .rating)
        self.location = try container.decode(String.self, forKey: .location)
        self.reputationImageURL = try container.decode(String.self, forKey: .reputationImageURL)
        self.shopLucky = try container.decode(String.self, forKey: .shopLucky)
        self.city = try container.decode(String.self, forKey: .city)
    }

}
