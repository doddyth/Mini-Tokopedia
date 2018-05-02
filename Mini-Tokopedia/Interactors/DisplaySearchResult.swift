//
//  DisplaySearchResult.swift
//  Mini-Tokopedia
//
//  Created by Doddy Tri Hutomo on 01/05/18.
//  Copyright © 2018 Doddy. All rights reserved.
//

import Foundation
import RxSwift

protocol DisplaySearchResultProtocol {
    func searchProduct(byKeyword keyword:String, page: Int, pageCount: Int,
                       filterInfo: FilterInfo?)
        -> Observable<[ProductViewParam]>
}

class DisplaySearchResult: DisplaySearchResultProtocol {
    
    let productApiService: ProductApiServiceProtocol!
    
    init(productApiService: ProductApiServiceProtocol) {
        self.productApiService = productApiService
    }
    
    func searchProduct(byKeyword keyword: String, page: Int, pageCount: Int,
                       filterInfo: FilterInfo?)
        -> Observable<[ProductViewParam]> {
            return productApiService.getProducts(byKeyword: keyword,
                                                 page: page,
                                                 pageCount: pageCount,
                                                 filterInfo: filterInfo)
                .map { products -> [ProductViewParam] in
                    products.map{ ProductViewParam.create($0) }
                }
    }
}
