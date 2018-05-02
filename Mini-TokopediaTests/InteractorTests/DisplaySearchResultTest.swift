//
//  DisplaySearchResultTest.swift
//  Mini-TokopediaTests
//
//  Created by Doddy Tri Hutomo on 01/05/18.
//  Copyright © 2018 Doddy. All rights reserved.
//

import XCTest
import RxSwift
import RxBlocking

@testable import Mini_Tokopedia

class DisplaySearchResultTest: XCTestCase {
    
    func testGetProducts() {
        let productApiServiceSuccessMock = ProductApiServiceSuccessMock()
        let displaySearchResult = DisplaySearchResult(productApiService: productApiServiceSuccessMock)
        
        let products: [ProductViewParam] = try! displaySearchResult.searchProduct(byKeyword: "test",
                                                                                  page: 1,
                                                                                  pageCount: 1,
                                                                                  filterInfo: nil)
            .toBlocking()
            .first()!
        
        XCTAssertEqual(products.count, 1)
        XCTAssertEqual(products.first!.id, "id")
        XCTAssertEqual(products.first!.name, "name")
        XCTAssertEqual(products.first!.imageURL, "image_url")
        XCTAssertEqual(products.first!.price, "price")
    }
    
    func testGetProductsWhenError() {
        let productApiServiceFailMock = ProductApiServiceFailMock()
        let displaySearchResult = DisplaySearchResult(productApiService: productApiServiceFailMock)
        
        let expectationError = expectation(description: "searchProduct should error")
        displaySearchResult.searchProduct(byKeyword: "test", page: 1, pageCount: 1,
                                          filterInfo: nil)
            .subscribe(onError: { error in
                expectationError.fulfill()
            })
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
}
