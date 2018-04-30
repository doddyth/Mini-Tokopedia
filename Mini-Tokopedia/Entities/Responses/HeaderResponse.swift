//
//  HeaderResponse.swift
//  Mini-Tokopedia
//
//  Created by Doddy Tri Hutomo on 30/04/18.
//  Copyright © 2018 Doddy. All rights reserved.
//

import Foundation

struct HeaderResponse: Codable {
    
    let totalData: Int?
    let totalDataWithNoCategory: Int?
    let additionalParams: String?
    let proccessTime: Double?
    let suggestionInstead: String?
    
    fileprivate enum HeaderKeys: String, CodingKey {
        case totalData = "total_data"
        case totalDataWithNoCategory = "total_data_no_category"
        case additionalParams = "additional_params"
        case processTime = "process_time"
        case suggestionInstead = "suggestion_instead"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: HeaderKeys.self)
        self.totalData = try container.decodeIfPresent(Int.self, forKey: .totalData)
        self.totalDataWithNoCategory = try container.decodeIfPresent(Int.self, forKey: .totalDataWithNoCategory)
        self.additionalParams = try container.decodeIfPresent(String.self, forKey: .additionalParams)
        self.proccessTime = try container.decodeIfPresent(Double.self, forKey: .processTime)
        self.suggestionInstead = try container.decodeIfPresent(String.self, forKey: .suggestionInstead)
    }
    
}
