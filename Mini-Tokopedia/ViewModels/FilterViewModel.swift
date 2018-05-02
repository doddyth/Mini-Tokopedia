//
//  FilterViewModel.swift
//  Mini-Tokopedia
//
//  Created by Doddy Tri Hutomo on 02/05/18.
//  Copyright © 2018 Doddy. All rights reserved.
//

import Foundation
import RxSwift

enum ShopType: String {
    case goldMerchant = "Gold Merchant"
    case officialStore = "Official Store"
}

class FilterViewModel {
    
    init() { }
    
    var currentShopTypes: Variable<[ShopType]> { return _currentShopTypes }
    fileprivate var _currentShopTypes: Variable<[ShopType]> = Variable<[ShopType]>([ShopType]())
    
    func shopTypeApplied(shopTypes: [ShopType]) {
        _currentShopTypes.value = shopTypes
    }
    
    func tapDeleteShopType(withShopType shopType: ShopType) {
        guard let index = _currentShopTypes.value.index(of: shopType)
            else { return }
        
        _currentShopTypes.value.remove(at: index)
    }
    
}
