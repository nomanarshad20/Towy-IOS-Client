//
//  AccountVM.swift
//  Towy
//
//  Created by Usman on 03/08/2022.
//

import Foundation

class AccountVM: BaseVM {
    
//    var firstName : String = ""
//    var lastName:String = ""
//    var actualNumber : String = ""

    
//    var isUserAvailable : LoginModel?{
//        didSet {
//            self.redirectControllerClosure?()
//        }
//    }
    

    
    // MARK: - DASHBOARD_HANDLING

    func setTableData() -> [AccountDataModel]{
        var arr = [AccountDataModel]()
        let obj_1 = AccountDataModel(title: "Messages", img: "letter")
//        let obj_2 = AccountDataModel(title: "Settings", img: "settings")
//        let obj_3 = AccountDataModel(title: "Legal", img: "info")
        let obj_4 = AccountDataModel(title: "Logout", img: "logout")
        arr.append(obj_1)
//        arr.append(obj_2)
//        arr.append(obj_3)
        arr.append(obj_4)

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
//    
//    func setDashBoardData() -> [String]{
//        return ["Towy Ride","Tire","Fuel","Battery Send","Lock","others"]
//    }
    
    // MARK: - API_Handling
    
    
    
    
    // MARK: - Alert
    
  
    // MARK: - Validation
    
    
}
