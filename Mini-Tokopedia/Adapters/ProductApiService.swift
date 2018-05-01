//
//  ProductApiService.swift
//  Mini-Tokopedia
//
//  Created by Doddy Tri Hutomo on 30/04/18.
//  Copyright © 2018 Doddy. All rights reserved.
//

import Foundation
import RxSwift

protocol ProductApiServiceProtocol {
    func getProducts(byKeyword keyword: String, page: Int, pageCount: Int) -> Observable<[Product]>
}

class ProductApiService: ProductApiServiceProtocol {

    fileprivate var apiClient: ApiClientProtocol
    
    fileprivate let searchPath: String = "search/v2.5/product"
    
    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }
    
    func getProducts(byKeyword keyword: String, page: Int, pageCount: Int)
        -> Observable<[Product]> {
            guard page > 0 && pageCount > 0 else {
                let error = NSError(domain: "com.minitokopedia",
                                    code: 0,
                                    userInfo: ["description": "page or pagecount can't be zero or less"])
                return Observable.error(error)
            }
            
            let searchFullPath = constructSearchFullPath(keyword,
                                                         page: page,
                                                         pageCount: pageCount)
            return apiClient.getString(searchFullPath, headers: Dictionary<String, String>())
                .map { jsonString -> Data in
                    Data(jsonString.utf8)
                }
                .flatMap { data -> Observable<[Product]> in
                    let jsonDecoder = JSONDecoder()
                    
                    do {
                        let productListResponse =
                            try jsonDecoder.decode(ProductListResponse.self, from: data)
                        let products = productListResponse.extractProducts()
                        return Observable.just(products)
                    } catch let error as NSError {
                        return Observable.error(error)
                    }
                }
    }
    
    //MARK: - Private
    
    fileprivate func constructSearchFullPath(_ keyword: String, page: Int, pageCount: Int) -> String {
        let start = (page - 1) * pageCount
        return "\(searchPath)?q=\(keyword)&start=\(start)&rows=\(pageCount)"
    }
}
