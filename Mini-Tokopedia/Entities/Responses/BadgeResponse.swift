//
//  BadgeResponse.swift
//  Mini-Tokopedia
//
//  Created by Doddy Tri Hutomo on 30/04/18.
//  Copyright © 2018 Doddy. All rights reserved.
//

import Foundation

struct BadgeResponse: Codable {
    
    let title: String?
    let imageURL: String?
    
    fileprivate enum BadgeKeys: String, CodingKey {
        case title
        case imageURL = "image_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: BadgeKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.imageURL = try container.decode(String.self, forKey: .imageURL)
    }
}
