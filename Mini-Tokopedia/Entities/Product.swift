//
//  Product.swift
//  Mini-Tokopedia
//
//  Created by Doddy Tri Hutomo on 01/05/18.
//  Copyright © 2018 Doddy. All rights reserved.
//

import Foundation

struct Product {
    var id: String = ""
    var name: String = ""
    var URL: String = ""
    var imageURL: String = ""
    var imageURL700: String = ""
    var price: String = ""
    var categoryBreadcrumb = ""
    var shop: Shop?
    var wholesalePrice: [WholesalePrice]?
    var condition: Bool = false
    var preorder: Bool = false
    var departmentId: String = ""
    var rating: Int = 0
    var isFeatured: Bool = false
    var countTalk: Int = 0
    var countSold: Int = 0
    var labels: [Label]?
    var badges: [Badge]?
    var originalPrice: String = ""
    var discountExpired: Date = Date.epoch()
    var discountStart: Date = Date.epoch()
    var discountPercentage: Int = 0
    var stock: Int = 0
}
