//
//  NetworkCall.swift
//  Towy
//
//  Created by Usman on 05/07/2022.
//

import Foundation
import Alamofire
import SwiftyJSON
class NetworkCall : NSObject{
    
    
    
    var parameters = Parameters()
    var headers = HTTPHeaders()
    var method: HTTPMethod!
    var url :String! = APPURL.BaseURL
    var encoding: ParameterEncoding! = JSONEncoding.default
    var showLoader = true
    init(data: [String:Any] = [:],headers: [String:String] = [:],url :String?,service :APPURL.services? = nil, method: HTTPMethod = .post, isJSONRequest: Bool = true,showLoader:Bool = true){
        super.init()
        data.forEach{parameters.updateValue($0.value, forKey: $0.key)}
        headers.forEach({self.headers.add(name: $0.key, value: $0.value)})
        self.showLoader = showLoader
        if url == nil, service != nil{
            self.url += service!.rawValue
        }else{
            self.url = url
        }
        if !isJSONRequest{
            encoding = URLEncoding.default
        }
        self.method = method
        print("Service: \(service?.rawValue ?? self.url ?? "") \n data: \(parameters)")
    }
    
    func executeQuery<T>(completion: @escaping (Result<T, Error>) -> Void) where T: Codable {
        if showLoader {SHOW_CUSTOM_LOADER()}
        
        
        AF.request(url,method: method,parameters: parameters,encoding: encoding, headers: headers).responseData(completionHandler: {response in
            if self.showLoader {HIDE_CUSTOM_LOADER()}
            switch response.result{
                
            case .success(let res):
                
                if let code = response.response?.statusCode{
                    print("responseData",String(data: res, encoding: .utf8) ?? "nothing received")
                    let a = res
                    let r = response
                    switch code {
                    case 200...299:
                        do {
                            completion(.success(try JSONDecoder().decode(T.self, from: res)))
                        } catch let error {
                            print("catch error",String(data: res, encoding: .utf8) ?? "nothing received")
                            completion(.failure(error))
                        }
                        
                    case 401:
                        print("user not exist")
                        let error = JSON(response.value)

                        do {
                            completion(.success(try JSONDecoder().decode(T.self, from: res)))
                        } catch let error {
                            print("catch error",String(data: res, encoding: .utf8) ?? "nothing received")
                            
                            completion(.failure(error))
                        }
                        
                    case 404:
                        
                        let error = JSON(response.value)
                        print("error",error.dictionaryObject?["message"] as? String ?? "")
                        UtilitiesManager.shared.showAlertView(title: Key.APP_NAME, message: error.dictionaryObject?["message"] as? String ?? "")

                        
                        //{"result":"error","message":"Driver Not Found","data":null}
                        
                        
                    case 422:
//                        print("alert message",response.data)
                        let error = JSON(response.value)

                        UtilitiesManager.shared.showAlertView(title: Key.APP_NAME, message: error.dictionaryObject?["message"] as? String ?? "")
                    default:
                        let errorss = JSON(response.result)

                     let error = NSError(domain: response.debugDescription, code: code, userInfo: response.response?.allHeaderFields as? [String: Any])
                        completion(.failure(error))
                    }
                }
            case .failure(let error):
                
                
                completion(.failure(error))
                
            }
        })
    }
}


/*
 
 
 {
     "result": "error",
     "message": "The email has already been taken.",
     "data": null
 }
 */
