//
//  ApiResponseTestUtil.swift
//  Mini-TokopediaTests
//
//  Created by Doddy Tri Hutomo on 01/05/18.
//  Copyright © 2018 Doddy. All rights reserved.
//

import Foundation
import XCTest

@testable import Mini_Tokopedia
class ApiResponseTestUtil {
    
    class func assertProducts(_ products: [Product]) {
        XCTAssertGreaterThan(products.count, 0)
        
        let product: Product = products.first!
        
        XCTAssertNotEqual(product.id, "0")
        XCTAssertFalse(product.name.isEmpty)
        XCTAssertFalse(product.imageURL.isEmpty)
        XCTAssertFalse(product.price.isEmpty)
    }
}
