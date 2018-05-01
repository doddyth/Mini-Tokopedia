//
//  LabelResponse.swift
//  Mini-Tokopedia
//
//  Created by Doddy Tri Hutomo on 30/04/18.
//  Copyright © 2018 Doddy. All rights reserved.
//

import Foundation

struct LabelResponse: Codable {
    
    let title: String?
    let color: String?
    
    fileprivate enum LabelKeys:String, CodingKey {
        case title
        case color
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: LabelKeys.self)
        self.title = try container.decode(String.self, forKey: .title)
        self.color = try container.decode(String.self, forKey: .color)
    }
    
    func extractLabel() -> Label {
        var label = Label()
        if let title = title { label.title = title }
        if let color = color { label.color = color }
        
        return label
    }
}
