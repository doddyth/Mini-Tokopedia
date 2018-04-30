//
//  ProductListResponse.swift
//  Mini-Tokopedia
//
//  Created by Doddy Tri Hutomo on 30/04/18.
//  Copyright © 2018 Doddy. All rights reserved.
//

import Foundation

struct ProductListResponse: Codable {
    
    let status: StatusResponse?
    let header: HeaderResponse?
    let products: [ProductResponse]?
    let category: CategoryListResponse?
    
    fileprivate enum ProductListKeys: String, CodingKey {
        case status
        case header
        case products = "data"
        case category
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ProductListKeys.self)
        self.status = try container.decodeIfPresent(StatusResponse.self, forKey: .status)
        self.header = try container.decodeIfPresent(HeaderResponse.self, forKey: .header)
        self.products = try container.decodeIfPresent([ProductResponse].self, forKey: .products)
        self.category = try container.decodeIfPresent(CategoryListResponse.self, forKey: .category)
    }
    
}
