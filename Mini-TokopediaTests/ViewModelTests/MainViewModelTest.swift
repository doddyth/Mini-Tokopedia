//
//  MainViewModelTest.swift
//  Mini-TokopediaTests
//
//  Created by Doddy Tri Hutomo on 01/05/18.
//  Copyright © 2018 Doddy. All rights reserved.
//

import XCTest
import RxSwift

@testable import Mini_Tokopedia

class DisplaySearchResultMock: DisplaySearchResultProtocol {
    func searchProduct(byKeyword keyword: String, page: Int, pageCount: Int,
                       filterInfo: FilterInfo?)
        -> Observable<[ProductViewParam]> {
            var products = [ProductViewParam]()
            for i in 0..<10 {
                var product = ProductViewParam()
                product.id = "test-id\(i)"
                product.name = "test-name\(i)"
                
                products.append(product)
            }
        
        return Observable.just(products)
    }
}

class MainViewModelTest: XCTestCase {
    
    var mainViewModel: MainViewModel?
    
    override func setUp() {
        super.setUp()
        let displaySearchResultMock = DisplaySearchResultMock()
        mainViewModel = MainViewModel(displaySearchResult: displaySearchResultMock)
    }
    
    func testDidLoad() {
        let loadingExpectation = expectation(description: "should send event loading shown")
        loadingExpectation.expectedFulfillmentCount = 3
        
        let productViewParamsExpectation = expectation(description: "should send event product view params")
        productViewParamsExpectation.expectedFulfillmentCount = 2
        
        var counterLoading: Int = 0
        mainViewModel?.loadingShown
            .asObservable()
            .subscribe(onNext: { loadingShown in
                if counterLoading == 0 {
                    XCTAssertFalse(loadingShown)
                } else if counterLoading == 1 {
                    XCTAssertTrue(loadingShown)
                } else if counterLoading == 2 {
                    XCTAssertFalse(loadingShown)
                }
                
                loadingExpectation.fulfill()
                counterLoading += 1
            })
        
        var counterProduct: Int = 0
        mainViewModel?.productViewParams
            .asObservable()
            .subscribe(onNext: { products in
                if counterProduct == 0 {
                    XCTAssertEqual(products.count, 0)
                } else {
                    XCTAssertEqual(products.count, 10)
                }
                
                productViewParamsExpectation.fulfill()
                counterProduct += 1
            })
        
        mainViewModel?.didLoad()
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testLoadMore() {
        let productViewParamsExpectation = expectation(description: "should send event product view params")
        productViewParamsExpectation.expectedFulfillmentCount = 3
        
        var counter: Int = 0
        mainViewModel?.productViewParams
            .asObservable()
            .subscribe(onNext: { products in
                if counter == 1 {
                    XCTAssertEqual(products.count, 10)
                } else if counter == 2 {
                    XCTAssertEqual(products.count, 20)
                }
                
                productViewParamsExpectation.fulfill()
                counter += 1
            })
        
        mainViewModel?.didLoad()
        mainViewModel?.loadMore()
        
        waitForExpectations(timeout: 10, handler: nil)
    }
    
    func testFilterApplied() {
        let productViewParamsExpectation = expectation(description: "should send event product view params")
        productViewParamsExpectation.expectedFulfillmentCount = 4
        
        var counter: Int = 0
        mainViewModel?.productViewParams
            .asObservable()
            .subscribe(onNext: { products in
                if counter == 1 {
                    XCTAssertEqual(products.count, 10)
                } else if counter == 2 {
                    XCTAssertEqual(products.count, 0)
                } else if counter == 3 {
                    XCTAssertEqual(products.count, 10)
                }
                
                productViewParamsExpectation.fulfill()
                counter += 1
            })
        
        mainViewModel?.didLoad()
        mainViewModel?.filterApplied(withInfo: FilterInfo())
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
