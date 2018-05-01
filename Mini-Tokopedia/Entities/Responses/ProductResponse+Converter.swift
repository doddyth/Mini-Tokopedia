//
//  ProductResponse+Converter.swift
//  Mini-Tokopedia
//
//  Created by Doddy Tri Hutomo on 01/05/18.
//  Copyright © 2018 Doddy. All rights reserved.
//

import Foundation

extension ProductResponse {
    func extractProduct() -> Product {
        var product = Product()
        if let id = self.id { product.id = id }
        if let name = self.name { product.name = name }
        if let URL = self.URL { product.URL = URL }
        if let imageURL = self.imageURL { product.imageURL = imageURL }
        if let imageURL700 = self.imageURL700 { product.imageURL700 = imageURL700 }
        if let price = self.price { product.price = price }
        if let categoryBreadcrumb = self.categoryBreadcrumb {
            product.categoryBreadcrumb = categoryBreadcrumb
        }
        if let condition = self.condition { product.condition = condition }
        if let preorder = self.preorder { product.preorder = preorder }
        if let departmentId = self.departmentId { product.departmentId = departmentId }
        if let rating = self.rating { product.rating = rating }
        if let isFeatured = self.isFeatured { product.isFeatured = isFeatured }
        if let countTalk = self.countTalk { product.countTalk = countTalk }
        if let countSold = self.countSold { product.countSold = countSold }
        if let originalPrice = self.originalPrice { product.originalPrice = originalPrice }
        if let discountExpired = self.discountExpired { product.discountExpired = discountExpired }
        if let discountStart = self.discountStart { product.discountStart = discountStart }
        if let discountPercentage = self.discountPercentage { product.discountPercentage = discountPercentage }
        if let stock = self.stock { product.stock = stock }
        
        if let shopResponse = self.shop {
            product.shop = shopResponse.extractShop()
        }
        if let wholesalePriceResponses = self.wholesalePrice {
            product.wholesalePrice = wholesalePriceResponses.map { $0.extractWholesalePrice() }
        }
        if let labels = self.labels {
            product.labels = labels.map { $0.extractLabel() }
        }
        if let badges = self.badges {
            product.badges = badges.map { $0.extractBadge() }
        }
        
        return product
    }
}
