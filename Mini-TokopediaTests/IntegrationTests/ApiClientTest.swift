//
//  ApiClientTest.swift
//  Mini-TokopediaTests
//
//  Created by Doddy Tri Hutomo on 30/04/18.
//  Copyright © 2018 Doddy. All rights reserved.
//

import XCTest
import RxSwift
import RxBlocking

@testable import Mini_Tokopedia

class ApiClientTest: XCTestCase {
    
    func testRequest() {
        let apiClient: ApiClient = ApiClient()
        
        let response = try! apiClient.getString("search/v2.5/product?q=samsung", headers: [:]).toBlocking().first()!
        
        XCTAssertFalse(response.isEmpty)
    }
    
}
