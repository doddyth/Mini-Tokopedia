//
//  StatusResponse.swift
//  Mini-Tokopedia
//
//  Created by Doddy Tri Hutomo on 30/04/18.
//  Copyright © 2018 Doddy. All rights reserved.
//

import Foundation

struct StatusResponse: Codable {
    
    let errorCode: Int?
    let message: String?
    
    fileprivate enum StatusKeys: String, CodingKey {
        case errorCode = "error_code"
        case message
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: StatusKeys.self)
        self.errorCode = try container.decodeIfPresent(Int.self, forKey: .errorCode)
        self.message = try container.decodeIfPresent(String.self, forKey: .message)
    }
    
}
