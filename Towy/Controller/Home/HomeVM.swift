//
//  HomeVM.swift
//  Towy
//
//  Created by Usman on 29/07/2022.
//

import Foundation
import UIKit
class HomeVM: BaseVM {
    
//    var firstName : String = ""
//    var lastName:String = ""
//    var actualNumber : String = ""

    
//    var isUserAvailable : LoginModel?{
//        didSet {
//            self.redirectControllerClosure?()
//        }
//    }
    

    
    // MARK: - DASHBOARD_HANDLING

    func setDashBoard(photoSliderView:PhotoSliderView){
        
        let images: [UIImage] = [UIImage(named: "image1")!,
                                 UIImage(named: "image2")!,
                                 UIImage(named: "image3")!,
                                 UIImage(named: "image1")!,
                                 UIImage(named: "image2")!,
                                 UIImage(named: "image3")!]
        
        photoSliderView.configure(with: images)

    }
    
//    func setDashBoardData() -> [String]{
//        return ["Towy Ride","Tire","Fuel","Battery Send","Lock","others"]
//    }

    
    func setDashBoardData() -> [AccountDataModel]{
        var arr = [AccountDataModel]()
        let obj_1 = AccountDataModel(title: "Tow", img: "car")
        let obj_2 = AccountDataModel(title: "Tire", img: "tire")
        let obj_3 = AccountDataModel(title: "Fuel", img: "fuel")
        let obj_4 = AccountDataModel(title: "Battery Send", img: "battery")
        let obj_5 = AccountDataModel(title: "Lock", img: "lock")
        let obj_6 = AccountDataModel(title: "others", img: "other")

        arr.append(obj_1)
        arr.append(obj_2)
        arr.append(obj_3)
        arr.append(obj_4)
        arr.append(obj_5)
        arr.append(obj_6)

        return arr
//        let images: [UIImage] = [UIImage(named: "image1")!,
//                                 UIImage(named: "image2")!,
//                                 UIImage(named: "image3")!,
//                                 UIImage(named: "image1")!,
//                                 UIImage(named: "image2")!,
//                                 UIImage(named: "image3")!]
//
//        photoSliderView.configure(with: images)

    }
    // MARK: - API_Handling
    
    
    
    
    // MARK: - Alert
    
  
    // MARK: - Validation
    
    
}
