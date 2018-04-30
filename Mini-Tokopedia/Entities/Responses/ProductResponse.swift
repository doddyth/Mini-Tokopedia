//
//  ProductResponse.swift
//  Mini-Tokopedia
//
//  Created by Doddy Tri Hutomo on 30/04/18.
//  Copyright © 2018 Doddy. All rights reserved.
//

import Foundation

struct ProductResponse: Codable {
    
    let id: String?
    let name: String?
    let URL: String?
    let imageURL: String?
    let imageURL700: String?
    let price: String?
    let categoryBreadcrumb: String?
    let shop: ShopResponse?
    let wholesalePrice: [WholesalePriceResponse]?
    let condition: Bool?
    let preorder: Bool?
    let departmentId: String?
    let rating: Int?
    let isFeatured: Bool?
    let countReview: Int?
    let countTalk: Int?
    let countSold: Int?
    let labels: [LabelResponse]?
    let badges: [BadgeResponse]?
    let originalPrice: String?
    let discountExpired: Date?
    let discountStart: Date?
    let discountPercentage: Int?
    let stock: Int?
    
    fileprivate enum ProductKeys: String, CodingKey {
        case id
        case name
        case URL = "uri"
        case imageURL = "image_uri"
        case imageURL700 = "image_uri_700"
        case price
        case categoryBreadcrumb = "category_breadcrumb"
        case shop
        case wholesalePrice = "wholesale_price"
        case condition
        case preorder
        case departmentId = "department_id"
        case rating
        case isFeatured = "is_featured"
        case countReview = "count_review"
        case countTalk = "count_talk"
        case countSold = "count_sold"
        case labels
        case badges
        case originalPrice = "original_price"
        case discountExpired = "discount_expired"
        case discountStart = "discount_start"
        case discountPercentage = "discount_percentage"
        case stock
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: ProductKeys.self)
        self.id = String(try container.decode(Int.self, forKey: .id))
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.URL = try container.decodeIfPresent(String.self, forKey: .URL)
        self.imageURL = try container.decodeIfPresent(String.self, forKey: .imageURL)
        self.imageURL700 = try container.decodeIfPresent(String.self, forKey: .imageURL700)
        self.price = try container.decodeIfPresent(String.self, forKey: .price)
        self.categoryBreadcrumb = try container.decodeIfPresent(String.self, forKey: .categoryBreadcrumb)
        self.shop = try container.decodeIfPresent(ShopResponse.self, forKey: .shop)
        self.wholesalePrice = try container.decodeIfPresent([WholesalePriceResponse].self,
                                                            forKey: .wholesalePrice)
        self.rating = try container.decodeIfPresent(Int.self, forKey: .rating)
        
        if let condition = try container.decodeIfPresent(Int.self,
                                                         forKey: .condition) {
            self.condition = Bool(truncating: condition as NSNumber)
        } else {
            self.condition = nil
        }
        
        if let preorder = try container.decodeIfPresent(Int.self, forKey: .preorder) {
            self.preorder = Bool(truncating: preorder as NSNumber)
        } else {
            self.preorder = nil
        }
        
        if let deptId = try container.decodeIfPresent(Int.self, forKey: .departmentId) {
            self.departmentId = String(deptId)
        } else {
            self.departmentId = nil
        }
        
        if let isFeatured = try container.decodeIfPresent(Int.self,
                                                          forKey: .isFeatured) {
            self.isFeatured = Bool(truncating: isFeatured as NSNumber)
        } else {
            self.isFeatured = nil
        }
        
        self.countReview = try container.decodeIfPresent(Int.self, forKey: .countReview)
        self.countTalk = try container.decodeIfPresent(Int.self, forKey: .countTalk)
        self.countSold = try container.decodeIfPresent(Int.self, forKey: .countSold)
        self.labels = try container.decodeIfPresent([LabelResponse].self, forKey: .labels)
        self.badges = try container.decodeIfPresent([BadgeResponse].self, forKey: .badges)
        self.originalPrice = try container.decodeIfPresent(String.self, forKey: .originalPrice)
        self.discountExpired = try container.decodeIfPresent(Date.self,
                                                             forKey: .discountExpired)
        self.discountStart = try container.decodeIfPresent(Date.self,
                                                           forKey: .discountStart)
        self.discountPercentage = try container.decodeIfPresent(Int.self, forKey: .discountPercentage)
        self.stock = try container.decodeIfPresent(Int.self, forKey: .stock)
    }
}
