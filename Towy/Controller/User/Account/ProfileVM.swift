//
//  ProfileVM.swift
//  Towy
//
//  Created by Usman on 28/11/2022.
//

import Foundation

import Alamofire
import SwiftyJSON
class ProfileVM: BaseVM {
    
    var firstName = ""
    var lastName = ""
    
    
    
    func updateProfile(body:[String:Any],completion:@escaping (BookingCreatedModel) -> ()){
        let h = UtilitiesManager.shared.getAuthHeader()
        print("Header",h)

        /*
        NetworkCall(data: body, headers: UtilitiesManager.shared.getAuthHeader(), url: nil, service: APPURL.services.passengerUserInfoUpdate, method: .post,showLoader: true).executeQuery(){
            (result: Result<BookingCreatedModel,Error>) in
            switch result{
            case .success(let response):
                //completion(response)
                print("response",response)
                completion(response)
            case .failure(let error):
                //completion(nil,error)
                UtilitiesManager.shared.showAlertView(title: Key.APP_NAME, message: error.localizedDescription)
                print("errorzz",error.localizedDescription)
            }
        }
        */
    }
    /*
    func updateProfileInfo(params:[String:Any],imagesArray:[String:UIImage],completionHandler:@escaping (_ result : Bool, _ message:String?)-> Void){
         //let header = UtilityManager().getAuthHeader()
        let header = UtilitiesManager.shared.getAuthHeader()
        AF.upload(multipartFormData: { multipartFormData in
            
            for (key,value) in params {
                if let value = value as? String {
                    multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                }
            }
            
            for (k,v) in imagesArray {
                if  let imageData = v.jpegData(compressionQuality: 0.5) {
                    multipartFormData.append(imageData, withName: k, fileName: "\(k).png", mimeType: "image/jpeg")
                   
                }
            }
        }, to: APPURL.services.passengerUserInfoUpdate as! URLConvertible,
        headers: header,
                  {
            
        }
/*
        AF.upload(
            multipartFormData: { multipartFormData in
                
                for (key,value) in params {
                    if let value = value as? String {
                        multipartFormData.append(value.data(using: String.Encoding.utf8)!, withName: key)
                    }
                }
                
                for (k,v) in imagesArray {
                    if  let imageData = v.jpegData(compressionQuality: 0.5) {
                        multipartFormData.append(imageData, withName: k, fileName: "\(k).png", mimeType: "image/jpeg")
                       
                    }
                }
        },
            to: APPURL.services.passengerUserInfoUpdate,
            headers: header,
            encodingCompletion: { encodingResult in
                switch encodingResult {
                case .success(let upload, _, _):
                    
                    upload.uploadProgress(closure: { (progress) in
                        print(progress)
                    })
                    
                    upload.responseJSON{
                        response in
                        HIDE_CUSTOM_LOADER()
                        switch response.result {
                        case .success:
                            let swiftyJsonVar = JSON(response.result.value!)
                            if swiftyJsonVar["result"].string == "success"
                            {
                                if let mainDict = swiftyJsonVar["data"].dictionaryObject
                                {
                                    UtilityManager().saveUserSession(userDict: mainDict as NSDictionary, accessToken: swiftyJsonVar["accessToken"].string)
                                        completionHandler(true,nil)
                                }
                            }
                            else
                            {
                                if let mainDict = swiftyJsonVar["error"].dictionaryObject
                                {
                                    if  let userDict = mainDict["message"] as? String{
                                        completionHandler(false,userDict)
                                    }
                                    if  let userDict = mainDict["message"] as? [String]{
                                        completionHandler(false,userDict[0])
                                    }
                                }
                            }
                            break
                        case .failure(let error):
                            completionHandler(false,error.localizedDescription)
                        }
                    }
                case .failure(let encodingError):
                    print("FALLE ------------")
                    print(encodingError)
                }
        }
        )
        */
    }
    */
    
    func updateProfileInfo(imageData: Data?, parameters: [String : Any], onCompletion: ((_ isSuccess:Bool) -> Void)? = nil, onError: ((Error?) -> Void)? = nil){
//        let headers : HTTPHeader?
       // let header = UtilitiesManager.shared.getAuthHeader()
//        headers = [
//                "Accept": "application/json",
//                "Content-type": "multipart/form-data"
//          ]
        let headers: HTTPHeaders =
        [
            "Authorization": "Bearer \(UtilitiesManager.shared.getAuthToken())",
            "Accept": "application/json",
            "Content-Type": "application/json" ]
        //headers = header
       // let a = APPURL.services.passengerUserInfoUpdate.rawValue
        AF.upload(multipartFormData: { multipartFormData in
            
            for (key, value) in parameters {
                if let temp = value as? String {
                    multipartFormData.append(temp.data(using: .utf8)!, withName: key)
                }
                if let temp = value as? Int {
                    multipartFormData.append("\(temp)".data(using: .utf8)!, withName: key)
                }
                if let temp = value as? NSArray {
                    temp.forEach({ element in
                        let keyObj = key + "[]"
                        if let string = element as? String {
                            multipartFormData.append(string.data(using: .utf8)!, withName: keyObj)
                        } else
                        if let num = element as? Int {
                            let value = "\(num)"
                            multipartFormData.append(value.data(using: .utf8)!, withName: keyObj)
                        }
                    })
                }
            }
            
            if let data = imageData{
                multipartFormData.append(data, withName: "file", fileName: "\(Date.init().timeIntervalSince1970).png", mimeType: "image/png")
            }
        },
                  to: APPURL.services.passengerUserInfoUpdate.rawValue, method: .post , headers: headers)
        .responseJSON(completionHandler: { (response) in
            
            print(response)
            
            if let err = response.error{
                print(err)
                onError?(err)
                return
            }
            print("Succesfully uploaded")
            
            let json = response.data
            
            if (json != nil)
            {
                let jsonObject = JSON(json!)
                print(jsonObject)
            }
        })
    }
}
