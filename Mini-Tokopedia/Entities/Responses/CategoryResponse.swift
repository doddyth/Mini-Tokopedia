//
//  CategoryResponse.swift
//  Mini-Tokopedia
//
//  Created by Doddy Tri Hutomo on 01/05/18.
//  Copyright © 2018 Doddy. All rights reserved.
//

import Foundation

struct CategoryResponse: Codable {
    let id: String?
    let name: String?
    let totalData: String?
    let parentId: String?
    let childIdString: [String]?
    let level: Int?
    
    fileprivate enum CategoryKeys: String, CodingKey {
        case id
        case name
        case totalData = "total_data"
        case parentId = "parent_id"
        case childId = "child_id"
        case level
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CategoryKeys.self)
        if let id = try container.decodeIfPresent(Int.self, forKey: .id) {
            self.id = String(id)
        } else {
            self.id = nil
        }
        
        self.name = try container.decodeIfPresent(String.self, forKey: .name)
        self.totalData = try container.decodeIfPresent(String.self, forKey: .totalData)
        
        if let parentId = try container.decodeIfPresent(Int.self, forKey: .parentId) {
            self.parentId = String(parentId)
        } else {
            self.parentId = nil
        }
        
        if let childId: [Int] = try container.decodeIfPresent([Int].self, forKey: .childId) {
            self.childIdString = childId.map { String($0) }
        } else {
            self.childIdString = nil
        }
        
        self.level = try container.decodeIfPresent(Int.self, forKey: .level)
    }
}
