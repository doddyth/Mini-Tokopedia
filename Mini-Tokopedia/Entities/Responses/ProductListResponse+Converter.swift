//
//  ProductListResponse+Converter.swift
//  Mini-Tokopedia
//
//  Created by Doddy Tri Hutomo on 01/05/18.
//  Copyright © 2018 Doddy. All rights reserved.
//

import Foundation

extension ProductListResponse {
    
    func extractProducts() -> [Product] {
        var products: [Product] = [Product]()
        if let productResponses = self.products {
            products = productResponses.map { $0.extractProduct() }
        }
        
        return products
    }
}
