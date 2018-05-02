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
    
    func testErrorWhenProductStillEmpty() {
        let displaySearchResultMock = DisplaySearchResultFailMock()
        let mainViewModel = MainViewModel(displaySearchResult: displaySearchResultMock)
        
        let loadingExpectation = expectation(description: "should send event loading shown")
        loadingExpectation.expectedFulfillmentCount = 3
        
        let errorExpectation = expectation(description: "should send event error shown")
        errorExpectation.expectedFulfillmentCount = 3
        
        var counterLoading: Int = 0
        mainViewModel.loadingShown
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
        
        var counterError: Int = 0
        mainViewModel.errorShown
            .asObservable()
            .subscribe(onNext: { errorShown in
                if counterError == 0 {
                    XCTAssertFalse(errorShown)
                } else if counterError == 1 {
                    XCTAssertFalse(errorShown)
                } else if counterError == 2 {
                    XCTAssertTrue(errorShown)
                }
                
                errorExpectation.fulfill()
                counterError += 1
            })
        
        mainViewModel.didLoad()
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testErrorWhenProductNotEmpty() {
        let displaySearchResultMock = DisplaySearchResultFailMock()
        let mainViewModel = MainViewModel(displaySearchResult: displaySearchResultMock)
        
        let loadingExpectation = expectation(description: "should send event loading shown")
        loadingExpectation.expectedFulfillmentCount = 3
        
        let errorExpectation = expectation(description: "should send event error shown")
        errorExpectation.expectedFulfillmentCount = 3
        
        var counterLoading: Int = 0
        mainViewModel.loadingShown
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
        
        var counterError: Int = 0
        mainViewModel.errorBannerShown
            .asObservable()
            .subscribe(onNext: { errorShown in
                if counterError == 0 {
                    XCTAssertFalse(errorShown)
                } else if counterError == 1 {
                    XCTAssertFalse(errorShown)
                } else if counterError == 2 {
                    XCTAssertTrue(errorShown)
                }
                
                errorExpectation.fulfill()
                counterError += 1
            })
        
        mainViewModel.productViewParams.value = [ProductViewParam()]
        mainViewModel.didLoad()
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testTapRetry() {
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
        
        mainViewModel?.tapRetry()
        
        waitForExpectations(timeout: 1, handler: nil)
    }
}
