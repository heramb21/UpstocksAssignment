//
//  NetworkManager.swift
//  HerambUpstocksTest
//
//  Created by Heramb on 16/02/24.
//

import Alamofire
import SwiftyJSON
import UIKit

enum RequestError: Error {
    case unknownError
    case connectionError
    case authorizationError(JSON)
    case invalidRequest
    case notFound
    case invalidResponse
    case serverError
    case serverUnavailable
    case somethingWrong
    case usernameExist
    case moveToMissingQueue
}
enum NetworkResult {
    case success(Data)
    case failure(RequestError)
}
// MARK: - Singleton
// 1. You need only one instance in the whole project. Having multiple NetworkManager won’t give you any performance benefits. However, having one is an optimal solution regarding memory.
// 2. Other classes should use NetworkManager as dependency. You’ll use singleton shared instance only when injecting it to other objects or in composition root.
class NetworkManager : RequestInterceptor {
    static let shared: NetworkManager = {
        return NetworkManager()
    }()
    var validToken: String?
    var isRefreshing: Bool = false
    var request: Alamofire.Request?
    let retryLimit = 3
    func request(type:EndPointType, method: HTTPMethod, parameters: Parameters, headers: HTTPHeaders,
                 interceptor: RequestInterceptor? = nil, isLoader :Bool = true, vc : UIViewController?,completion: @escaping ((Any?), Error?)-> Void){
        var en : ParameterEncoding
        if method == .get{
            en = URLEncoding.queryString
        }else{
            en = JSONEncoding.prettyPrinted
        }
        if isLoader == false{
            
        }else{
            DispatchQueue.main.async {
//                vc?.lottieStartAnimating(vc: vc)
                print("Start Loader Here")
            }
        }
        let systemVersion = UIDevice.current.systemVersion
        let headerz : HTTPHeaders  = []
        //#if DEBUG
        print("Alamofire Implementation---->")
        print("Header  : \(headerz)")
        print("Parameters  : \(parameters)")
        print("url  : \(type.url)")
        //#endif
        AF.request(type.url, method: method, parameters:parameters,encoding:en,
                   headers: headerz, interceptor: interceptor ?? self).validate().responseJSON { (response) in
            let statusCode = response.response?.statusCode ?? 0
            debugPrint("Status Code : \(statusCode)")
            switch statusCode {
            case 401 :
                DispatchQueue.main.async {
                    print("401")
                }
                break
            case 404 :
                debugPrint("API is not deployed or : \(String(describing: response.error?.localizedDescription))")
            default :
                break
            }
            switch response.result {
            case .success(_):
                do {
                    if let json = try JSONSerialization.jsonObject(with: response.data!, options: .mutableContainers) as? [String: Any] {
                        print("JSON data : \(json)")
                    }
                }
                catch let error as NSError {
                    print("Failed to load: \(error.localizedDescription)")
                }
                completion(response.data ,nil)
            case .failure(let error):
                print("Request failed with error: \(error)")
                completion(nil ,response.error)
            }
        }
    }
}
