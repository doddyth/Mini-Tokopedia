//
//  DisplaySearchResultMock.swift
//  Mini-TokopediaTests
//
//  Created by Doddy Tri Hutomo on 02/05/18.
//  Copyright © 2018 Doddy. All rights reserved.
//

import Foundation
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

class DisplaySearchResultFailMock: DisplaySearchResultProtocol {
    func searchProduct(byKeyword keyword: String, page: Int, pageCount: Int,
                       filterInfo: FilterInfo?)
        -> Observable<[ProductViewParam]> {
            return Observable.error(NSError())
    }
}
