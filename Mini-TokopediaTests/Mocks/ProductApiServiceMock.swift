//
//  ProductApiServiceMock.swift
//  Mini-TokopediaTests
//
//  Created by Doddy Tri Hutomo on 01/05/18.
//  Copyright © 2018 Doddy. All rights reserved.
//

import Foundation
import RxSwift

@testable import Mini_Tokopedia
class ProductApiServiceSuccessMock: ProductApiServiceProtocol {
    func getProducts(byKeyword keyword: String, page: Int, pageCount: Int)
        -> Observable<[Product]> {
            var product = Product()
            product.id = "id"
            product.name = "name"
            product.imageURL = "image_url"
            product.price = "price"
            return Observable.just([product])
    }
}

class ProductApiServiceFailMock: ProductApiServiceProtocol {
    func getProducts(byKeyword keyword: String, page: Int, pageCount: Int)
        -> Observable<[Product]> {
            return Observable.error(NSError())
    }
}
