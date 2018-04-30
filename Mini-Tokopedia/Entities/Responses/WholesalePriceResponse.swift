//
//  WholesalePriceResponse.swift
//  Mini-Tokopedia
//
//  Created by Doddy Tri Hutomo on 30/04/18.
//  Copyright © 2018 Doddy. All rights reserved.
//

import Foundation

struct WholesalePriceResponse: Codable {
    let countMin: Int?
    let countMax: Int?
    let price: String?
    
    fileprivate enum WholesalePriceKeys: String, CodingKey {
        case countMin = "count_min"
        case countMax = "count_max"
        case price
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: WholesalePriceKeys.self)
        self.countMin = try container.decode(Int.self, forKey: .countMin)
        self.countMax = try container.decode(Int.self, forKey: .countMax)
        self.price = try container.decode(String.self, forKey: .price)
    }
    
}
