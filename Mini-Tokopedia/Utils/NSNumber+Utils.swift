//
//  NSNumber+Utils.swift
//  Mini-Tokopedia
//
//  Created by Doddy Tri Hutomo on 02/05/18.
//  Copyright © 2018 Doddy. All rights reserved.
//

import Foundation

extension NSNumber {
    func currencyString() -> String? {
        let formatter: NumberFormatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.locale = Locale(identifier: "id_ID")
        formatter.maximumFractionDigits = 0
        
        return formatter.string(from: self)
    }
}
