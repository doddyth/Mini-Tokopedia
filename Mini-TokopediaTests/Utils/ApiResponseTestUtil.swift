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
    
    class func assertProductListResponse(_ productListResponse: ProductListResponse) {
        XCTAssertGreaterThan(productListResponse.products!.count, 0)
        XCTAssertGreaterThan(productListResponse.category!.data!.count, 0)
        
        let product: ProductResponse = productListResponse.products!.first!
        
        XCTAssertNotEqual(product.id, "0")
        XCTAssertFalse(product.name!.isEmpty)
        XCTAssertFalse(product.imageURL!.isEmpty)
        XCTAssertFalse(product.price!.isEmpty)
    }
    
    class func assertEmptyProductListResponse(_ productListResponse: ProductListResponse) {
        XCTAssertEqual(productListResponse.products!.count, 0)
        XCTAssertEqual(productListResponse.category!.data!.count, 0)
    }
}
