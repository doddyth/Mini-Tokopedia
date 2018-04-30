//
//  ApiClient.swift
//  Mini-Tokopedia
//
//  Created by Doddy Tri Hutomo on 30/04/18.
//  Copyright © 2018 Doddy. All rights reserved.
//

import Foundation
import RxSwift
import Alamofire


protocol ApiClientProtocol {
    func getString(_ path: String, headers: [String: String]) -> Observable<String>
}

class ApiClient: ApiClientProtocol {
    
    fileprivate let host = "https://ace.tokopedia.com/"
    
    func getString(_ path: String, headers: [String : String]) -> Observable<String> {
        return get(endPoint: path, headers: headers)
    }
    
    //MARK: - Private
    
    fileprivate func get(endPoint: String, headers: [String: String] = [:]) -> Observable<String> {
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
        }
        
        return request(endPoint: endPoint, method: .get, headers: headers)
    }
    
    fileprivate func request(endPoint: String,
                             method: HTTPMethod = .get,
                             parameters: [String: Any] = [:],
                             headers: [String: String] = [:],
                             encoding: ParameterEncoding = URLEncoding.default) -> Observable<String> {
        return rxRequest(endPoint: endPoint,
                         method: method,
                         headers: headers,
                         encoding: encoding)
            .do(
                onError: { _ in
                UIApplication.shared.isNetworkActivityIndicatorVisible = false
            },
                onCompleted: {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
            })
            .map { (_, _, responseString) -> String in
                responseString
        }
    }
    
    fileprivate func rxRequest(endPoint: String,
                               method: HTTPMethod = .get,
                               headers: [String: String] = [:],
                               encoding: ParameterEncoding = URLEncoding.default)
        -> Observable<(HTTPURLResponse, URLRequest, String)> {
            return Observable.create{ [weak self] observer in
                guard let weakSelf = self else { return Disposables.create {} }
                
                let request = Alamofire.request(weakSelf.createURL(endPoint),
                                                method: method,
                                                parameters: [:],
                                                encoding: encoding,
                                                headers: headers)
                    .responseString(completionHandler: { response in
                        if let responseString = response.result.value,
                            let urlRequest = response.request,
                            let urlResponse = response.response {
                            observer.on(.next((urlResponse, urlRequest, responseString)))
                        } else if let error = response.result.error {
                            observer.on(.error(error))
                        }
                        observer.on(.completed)
                    })
                
                return Disposables.create {
                    request.cancel()
                }
            }
    }
    
    fileprivate func createURL(_ path: String) -> String {
        return host + path
    }
    
}
