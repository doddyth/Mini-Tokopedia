//
//  MainViewModel.swift
//  Mini-Tokopedia
//
//  Created by Doddy Tri Hutomo on 01/05/18.
//  Copyright © 2018 Doddy. All rights reserved.
//

import Foundation
import RxSwift

class MainViewModel {
    let displaySearchResult: DisplaySearchResultProtocol!
    
    var loadingShown : Variable<Bool> { return _loadingShown }
    fileprivate var _loadingShown: Variable<Bool> = Variable<Bool>(false)
    
    var errorShown: Variable<Bool> { return _errorShown }
    fileprivate var _errorShown: Variable<Bool> = Variable<Bool>(false)
    
    var errorBannerShown: Variable<Bool> { return _errorBannerShown }
    fileprivate var _errorBannerShown: Variable<Bool> = Variable<Bool>(false)
    
    var productViewParams : Variable<[ProductViewParam]> { return _productViewParams }
    fileprivate var _productViewParams: Variable<[ProductViewParam]> = Variable<[ProductViewParam]>([ProductViewParam]())
    
    var currentFilterInfo: FilterInfo?
    
    var allProductLoaded: Bool { return _allProductLoaded }
    fileprivate var _allProductLoaded: Bool = false
    
    fileprivate let disposeBag = DisposeBag()
    fileprivate var currentPage = 1
    fileprivate var pageCount = 10
    
    
    init(displaySearchResult: DisplaySearchResultProtocol) {
        self.displaySearchResult = displaySearchResult
    }
    
    func didLoad() {
        loadingShown.value = true
        searchProduct(byKeyword: "samsung", page: currentPage, pageCount: pageCount)
    }
    
    func tapRetry() {
        loadingShown.value = true
        searchProduct(byKeyword: "samsung", page: currentPage, pageCount: pageCount)
    }
    
    func loadMore() {
        guard !_allProductLoaded else { return }
        
        currentPage += 1
        searchProduct(byKeyword: "samsung", page: currentPage, pageCount: pageCount,
                      filterInfo: currentFilterInfo)
    }
    
    func filterApplied(withInfo filterInfo: FilterInfo) {
        currentFilterInfo = filterInfo
        currentPage = 1
        _productViewParams.value = [ProductViewParam]()
        
        loadingShown.value = true
        searchProduct(byKeyword: "samsung", page: currentPage, pageCount: pageCount,
                      filterInfo: currentFilterInfo)
    }
    
    //MARK: - Private
    
    fileprivate func searchProduct(byKeyword keyword: String, page: Int, pageCount: Int, filterInfo: FilterInfo? = nil) {
        errorShown.value = false
        errorBannerShown.value = false
        
        self.displaySearchResult.searchProduct(byKeyword: keyword, page: page,
                                               pageCount: pageCount,
                                               filterInfo: filterInfo)
            .subscribe (
                onNext: { [weak self] productViewParams in
                    self?._allProductLoaded = (productViewParams.count == 0 || productViewParams.count < 10)
                    self?._productViewParams.value.append(contentsOf: productViewParams)
                }, onError: { [weak self] error in
                    guard let weakSelf = self else { return }
                    
                    weakSelf.loadingShown.value = false
                    weakSelf.errorBannerShown.value = weakSelf._productViewParams.value.count > 0
                    weakSelf.errorShown.value = weakSelf._productViewParams.value.count == 0
                }, onCompleted: { [weak self] in
                self?.loadingShown.value = false
            })
            .disposed(by: disposeBag)
    }
}
