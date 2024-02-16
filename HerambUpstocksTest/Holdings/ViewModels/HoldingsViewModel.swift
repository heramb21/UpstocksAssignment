//
//  HoldingsViewModel.swift
//  HerambUpstocksTest
//
//  Created by Heramb on 16/02/24.
//

import Foundation
import UIKit
import Alamofire

class PortfolioViewModel{
    weak var vc: ViewController?
    
    //   Network calls are here
    //   Get the user's portfolio details.
    func callAPi() {
        
        let headers : HTTPHeaders = []
        
        NetworkManager.shared.request(type: EndpointItem.getUserHoldings, method: .get, parameters:[:], headers:headers, interceptor: nil, vc:vc) { data, error  in
            guard let data = data else {return}
            do{
                let decoder = JSONDecoder()
                let json = try decoder.decode(UserHoldingResponse.self, from:data as! Data)
                print(json)
            }catch{
                print(error.localizedDescription)
            }
        }
    }
}
