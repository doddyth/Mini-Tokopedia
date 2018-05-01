//
//  ProductViewParam.swift
//  Mini-Tokopedia
//
//  Created by Doddy Tri Hutomo on 01/05/18.
//  Copyright © 2018 Doddy. All rights reserved.
//

import Foundation

struct ProductViewParam {
    var id: String = ""
    var name: String = ""
    var price: String = ""
    var imageURL: String = ""
    
    static func create(_ product: Product) -> ProductViewParam {
        var productViewParam = ProductViewParam()
        productViewParam.id = product.id
        productViewParam.name = product.name
        productViewParam.price = product.price
        productViewParam.imageURL = product.imageURL
        
        return productViewParam
    }
}
