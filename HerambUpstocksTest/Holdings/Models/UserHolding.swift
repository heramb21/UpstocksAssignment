//
//  UserHolding.swift
//  UpstocksAssignment
//
//  Created by Heramb on 15/02/24.
//

import Foundation


// MARK: - UserHolding Object
struct UserHolding: Codable {
    
    let symbol: String?
    let quantity: Int?
    let ltp: Double?
    let avgPrice: Double?
    let close: Int?
    
    enum CodingKeys: String, CodingKey {
        case symbol = "symbol"
        case quantity = "quantity"
        case ltp = "ltp"
        case avgPrice = "avgPrice"
        case close = "close"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        symbol = try? values.decodeIfPresent(String.self, forKey: .symbol)
        quantity = try (values.decodeIfPresent(Int.self, forKey: .quantity) ?? 0)
        ltp = try (values.decodeIfPresent(Double.self, forKey: .ltp) ?? 0.0)
        avgPrice = try (values.decodeIfPresent(Double.self, forKey: .avgPrice) ?? 0.0)
        close = try (values.decodeIfPresent(Int.self, forKey: .close) ?? 0)
    }
    
}
