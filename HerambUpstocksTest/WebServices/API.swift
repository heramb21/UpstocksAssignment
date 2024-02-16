//
//  API.swift
//  HerambUpstocksTest
//
//  Created by Heramb on 16/02/24.
//

import Foundation

protocol EndPointType {
    // MARK: - Vars & Lets
    var baseURL: String { get }
    var path: String { get }
    var url: URL { get }
}

enum NetworkEnvironment {
    case dev
    case production
    case integration
}
enum EndpointItem{
    case getUserHoldings
}

extension EndpointItem: EndPointType {
    var baseURL: String {
        switch API.networkEnviroment {
        case .dev:
            print("Development setup Done")
            return "https://dev-api"
        case .integration:
            print("Integraton setup Done")
            return "https://run.mocky.io/v3"
        case .production:
            print("Production setup Done")
            return "https://production-api"
        }
    }
    var path: String {
        switch self {
        case .getUserHoldings:
            return "/bde7230e-bc91-43bc-901d-c79d008bddc8"
        }
    }
    var url: URL {
        switch self {
        default:
            return URL(string: self.baseURL + self.path)!
        }
    }
}

class API{
    
    static let shared: API = {
        return API()
    }()
    static let networkEnviroment: NetworkEnvironment = .integration
}
