//
//  ProductApiServiceTest.swift
//  Mini-TokopediaTests
//
//  Created by Doddy Tri Hutomo on 01/05/18.
//  Copyright © 2018 Doddy. All rights reserved.
//

import XCTest
import RxSwift
import RxBlocking

@testable import Mini_Tokopedia
class ProductApiServiceTest: XCTestCase {
    
    var productApiService: ProductApiService?
    
    override func setUp() {
        super.setUp()
        
        
        productApiService = ProductApiService(apiClient: ApiClient())
    }
    
    func testGetProductsByKeyword() {
        let searchResult = try! productApiService!.getProducts(byKeyword: "samsung",
                                                               page: 1,
                                                               pageCount: 1)
            .toBlocking()
            .first()!
        
        ApiResponseTestUtil.assertProductListResponse(searchResult)
    }
    
    func testGetProductsByKeywordWhenKeywordEmpty() {
        let searchResult = try! productApiService!.getProducts(byKeyword: "",
                                                               page: 1,
                                                               pageCount: 1)
            .toBlocking()
            .first()!
        
        ApiResponseTestUtil.assertEmptyProductListResponse(searchResult)
    }
    
    func testGetProductsByKeywordWhenPageLessThanZero() {
        let expectationError = expectation(description: "getProducts should error")
        
        productApiService!.getProducts(byKeyword: "samsung",
                                       page: -1,
                                       pageCount: 1)
            .subscribe(
                onError: { error in
                    let error = error as NSError
                    XCTAssertEqual(error.domain, "com.minitokopedia")
                    XCTAssertEqual(error.code, 0)
                    XCTAssertEqual(error.userInfo["description"] as! String, "page or pagecount can't be zero or less")
                    expectationError.fulfill()
            })
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testGetProductsByKeywordWhenPageCountLessThanZero() {
        let expectationError = expectation(description: "getProducts should error")
        
        productApiService!.getProducts(byKeyword: "samsung",
                                       page: 1,
                                       pageCount: -1)
            .subscribe(
                onError: { error in
                    let error = error as NSError
                    XCTAssertEqual(error.domain, "com.minitokopedia")
                    XCTAssertEqual(error.code, 0)
                    XCTAssertEqual(error.userInfo["description"] as! String, "page or pagecount can't be zero or less")
                    expectationError.fulfill()
            })
        
        waitForExpectations(timeout: 10, handler: nil)
    }
}
