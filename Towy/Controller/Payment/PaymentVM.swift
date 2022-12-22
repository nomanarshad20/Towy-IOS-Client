//
//  PaymentVM.swift
//  Towy
//
//  Created by Usman on 07/09/2022.
//

import Foundation

enum dataValidation{
    case name
    case cardNumber
    case CVC
    case month
    case year
}
//enum isValid {
//    case success
//    case failure(String)
//}
class PaymentVM : BaseVM{

    var name : String = ""
    var number : String = ""
    var month : String = ""
    var year : String = ""
    var cvc : String = ""
    
    
    var checkValidation = dataValidation.name

//    var arrMonth = [String]()
//    var arrYear = [String]()

    
    // MARK: - DASHBOARD_HANDLING


    func apiCall(completion:@escaping (StripeModel) -> ()){
        
        let isValid = self.checkValidationPayment()
        switch isValid {
        case .success:
            callStripApi{ data in
                completion(data)
            }
        case .failure(let msg):
            UtilitiesManager.shared.showAlertView(title: Key.APP_NAME, message: msg)
        }
    }

    
    func callStripApi(completion:@escaping (StripeModel) -> ()){
        //let h = UtilitiesManager.shared.getAuthHeader()
        
        
        let body = ["name":name,"number":number,"expiry_month":month,"expiry_year":year,"cvc":cvc] as [String:Any]

        NetworkCall(data: body, headers: UtilitiesManager.shared.getAuthHeader(), url: nil, service: APPURL.services.createStrip, method: .post, showLoader: true).executeQuery(){
            (result: Result<StripeModel,Error>) in
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
    }
    /*
    func getDateAndMonth(completion:([String],[String]) -> ()){
        let components = (Calendar.current as NSCalendar).components([.day, .month, .year], from: Date())
        let year = components.year
        let expiryMonth = (components.month!...12).compactMap { return "\($0)"}
        var expiryYear :[String] = [String]()
        var i = year! - 1
        while i <= year! + 20 {
            i = i + 1
            let yearString = String(i)
            expiryYear.append(yearString)
        }
        
        completion(expiryMonth, expiryYear)
    }
    */
    func getDateAndMonth(completion:([String],[String]) -> ()){
       // let nextYear = Calendar.current.date(byAdding: .year, value: 1, to: Date()) ?? Date()

        
        let components = (Calendar.current as NSCalendar).components([.day, .month, .year], from: Date())
//        let componentsForNextYear = (Calendar.current as NSCalendar).components([.day, .month, .year], from: nextYear)

        let year = components.year
        let expiryMonth = (components.month!...12).compactMap { return "\($0)"}
        //let allMonths = (componentsForNextYear.month!...12).compactMap { return "\($0)"}

        var expiryYear :[String] = [String]()
        var i = year! - 1
        while i <= year! + 20 {
            i = i + 1
            let yearString = String(i)
            expiryYear.append(yearString)
        }
        
        completion(expiryMonth,expiryYear)
   
    }
    
    func getNextYearsDate(){
        
        //let nextTwentyYear = Calendar.current.date(byAdding: .year, value: 20, to: Date())

        
    }
    
    
    // MARK: - Alert
    
  
    // MARK: - Validation
    func errorMsg(str: String) -> Valid {
        return .failure(str)
    }
    
    
    // MARK: - Validation
    func checkValidationPayment() -> Valid {
        let status = checkPaymentdFields()
        switch status {
        case true:
            return .success
        case false:
            return errorMsg(str:returnErrorMessage(validation:checkValidation))
        }
        
    }
    
    func checkPaymentdFields() -> Bool{
        guard !name.isEmpty else{checkValidation = .name;return false}
        guard !number.isEmpty else{checkValidation = .cardNumber;return false}
        guard !cvc.isEmpty else{checkValidation = .CVC;return false}
        guard !month.isEmpty else{checkValidation = .month;return false}
        guard !year.isEmpty else{checkValidation = .year;return false}

        return true
    }
    
    func returnErrorMessage(validation:dataValidation) -> String{
        //let validation = validation.email
        switch validation{
        case .name:
            return Key.ErrorMessage.NAMEFIELD
        case .cardNumber:
            return Key.ErrorMessage.CARDNUMBERFIELD
        case .CVC:
            return Key.ErrorMessage.CVCFIELD
        case .month:
            return Key.ErrorMessage.MONTHFIELD
        case .year:
            return Key.ErrorMessage.YEARFIELD

        }
    }
    
    
}
