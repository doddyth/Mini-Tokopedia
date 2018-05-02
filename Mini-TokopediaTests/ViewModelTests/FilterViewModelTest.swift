//
//  FilterViewModelTest.swift
//  Mini-TokopediaTests
//
//  Created by Doddy Tri Hutomo on 02/05/18.
//  Copyright © 2018 Doddy. All rights reserved.
//

import XCTest
import RxSwift

@testable import Mini_Tokopedia
class FilterViewModelTest: XCTestCase {
    
    func testShopTypeApplied() {
        let filterViewModel = FilterViewModel()
        
        let shopTypesExpectation = expectation(description: "should send shop types")
        shopTypesExpectation.expectedFulfillmentCount = 2
        
        var counter = 0
        filterViewModel.currentShopTypes
            .asObservable()
            .subscribe(onNext: { shopTypes in
                if counter == 0 {
                    XCTAssertEqual(shopTypes.count, 0)
                } else {
                    XCTAssertEqual(shopTypes.count, 2)
                }
                
                shopTypesExpectation.fulfill()
                counter += 1
            })
        
        filterViewModel.shopTypeApplied(shopTypes: [.goldMerchant, .officialStore])
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testTapDeleteShopType() {
        let filterViewModel = FilterViewModel()
        
        let shopTypesExpectation = expectation(description: "should send shop types")
        shopTypesExpectation.expectedFulfillmentCount = 3
        
        var counter = 0
        filterViewModel.currentShopTypes
            .asObservable()
            .subscribe(onNext: { shopTypes in
                if counter == 0 {
                    XCTAssertEqual(shopTypes.count, 0)
                } else if counter == 1 {
                    XCTAssertEqual(shopTypes.count, 2)
                } else if counter == 2 {
                    XCTAssertEqual(shopTypes.count, 1)
                }
                
                shopTypesExpectation.fulfill()
                counter += 1
            })
        
        filterViewModel.shopTypeApplied(shopTypes: [.goldMerchant, .officialStore])
        filterViewModel.tapDeleteShopType(withShopType: .goldMerchant)
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
    func testTapDeleteShopTypeWhenNotExist () {
        let filterViewModel = FilterViewModel()
        
        let shopTypesExpectation = expectation(description: "should send shop types")
        shopTypesExpectation.expectedFulfillmentCount = 2
        
        var counter = 0
        filterViewModel.currentShopTypes
            .asObservable()
            .subscribe(onNext: { shopTypes in
                if counter == 0 {
                    XCTAssertEqual(shopTypes.count, 0)
                } else {
                    XCTAssertEqual(shopTypes.count, 1)
                }
                
                shopTypesExpectation.fulfill()
                counter += 1
            })
        
        filterViewModel.shopTypeApplied(shopTypes: [.officialStore])
        filterViewModel.tapDeleteShopType(withShopType: .goldMerchant)
        
        waitForExpectations(timeout: 1, handler: nil)
    }
    
}
