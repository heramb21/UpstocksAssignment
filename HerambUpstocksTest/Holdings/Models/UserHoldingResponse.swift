//
//  UserHoldingResponse.swift
//  UpstocksAssignment
//
//  Created by Heramb on 15/02/24.
//

import Foundation

// MARK: - UserHoldingResponse
struct UserHoldingResponse: Codable {
    let userHolding:[UserHolding]?
   
    enum CodingKeys: String, CodingKey {
        case userHolding = "userHolding"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        userHolding = try values.decodeIfPresent([UserHolding].self, forKey: .userHolding)
    }
}

