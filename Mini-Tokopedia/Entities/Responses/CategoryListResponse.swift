//
//  CategoryListResponse.swift
//  Mini-Tokopedia
//
//  Created by Doddy Tri Hutomo on 30/04/18.
//  Copyright © 2018 Doddy. All rights reserved.
//

import Foundation

struct CategoryListResponse: Codable {
    let data: [CategoryResponse]?
    
    fileprivate enum CategoryListKeys: String, CodingKey {
        case data
    }
    
    struct CategoryIdKey: CodingKey {
        var stringValue: String
        init?(stringValue: String) {
            self.stringValue = stringValue
        }
        
        var intValue: Int? { return nil }
        init?(intValue: Int) { return nil }
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CategoryListKeys.self)
        self.data = []
        
        do {
            let categoryData = try container.nestedContainer(keyedBy: CategoryIdKey.self,
                                                             forKey: .data)
            
            for key in categoryData.allKeys {
                if let categoryResponse = try categoryData.decodeIfPresent(CategoryResponse.self,
                                                                           forKey: key) {
                    self.data?.append(categoryResponse)
                }
            }
        } catch { return }
        
    }
}
