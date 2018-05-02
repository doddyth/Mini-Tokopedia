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
    func getProducts(byKeyword keyword: String, page: Int, pageCount: Int,
                     filterInfo: FilterInfo?) -> Observable<[Product]>
}

class ProductApiService: ProductApiServiceProtocol {

    fileprivate var apiClient: ApiClientProtocol
    
    fileprivate let searchPath: String = "search/v2.5/product"
    
    init(apiClient: ApiClientProtocol) {
        self.apiClient = apiClient
    }
    
    func getProducts(byKeyword keyword: String, page: Int, pageCount: Int,
                     filterInfo: FilterInfo?)
        -> Observable<[Product]> {
            guard page > 0 && pageCount > 0 else {
                let error = NSError(domain: "com.minitokopedia",
                                    code: 0,
                                    userInfo: ["description": "page or pagecount can't be zero or less"])
                return Observable.error(error)
            }
            
            let searchFullPath = constructSearchFullPath(keyword,
                                                         page: page,
                                                         pageCount: pageCount,
                                                         filterInfo: filterInfo)
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
    
    fileprivate func constructSearchFullPath(_ keyword: String,
                                             page: Int,
                                             pageCount: Int,
                                             filterInfo: FilterInfo?) -> String {
        let start = (page - 1) * pageCount
        let initialPath = "\(searchPath)?q=\(keyword)&start=\(start)&rows=\(pageCount)"
        
        guard let filterInfo = filterInfo else { return initialPath }
        
        let officialStoreParam = filterInfo.shopTypes.contains(.officialStore) ? "&official=true" : ""
        let goldMerchantParam = filterInfo.shopTypes.contains(.goldMerchant) ? "&fshop=2" : ""
        
        return initialPath + "&pmin=\(filterInfo.minPrice)&pmax=\(filterInfo.maxPrice)" +
        "&wholesale=\(filterInfo.isWholeSale ? "true" : "false")" + officialStoreParam +
        goldMerchantParam
    }
}
