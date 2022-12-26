//
//  EditAccountVM.swift
//  Towy
//
//  Created by user on 13/08/2022.
//

import Foundation

class EditAccountVM: BaseVM {
    
//    var firstName : String = ""
//    var lastName:String = ""
//    var actualNumber : String = ""

    
//    var isUserAvailable : LoginModel?{
//        didSet {
//            self.redirectControllerClosure?()
//        }
//    }
    

    
    // MARK: - DASHBOARD_HANDLING

    func getData() -> [ProfileModel]{
        var arr = [ProfileModel]()
//         let getUserData = UtilitiesManager.shared.retriveUserLoginData()
        if let social = UtilitiesManager.shared.retriveSocialUserData(){
            let obj_1 = ProfileModel(title: "First name", subTitle: social.data?.first_name ?? "")
            let obj_2 = ProfileModel(title: "Last name", subTitle: social.data?.last_name ?? "" )
            let obj_3 = ProfileModel(title: "Email", subTitle: social.data?.email ?? "" )
            let obj_4 = ProfileModel(title: "Phone", subTitle: social.data?.mobile_no  ?? "" )
            arr.append(obj_1)
            arr.append(obj_2)
            arr.append(obj_3)
            arr.append(obj_4)

        }
        else if let login = UtilitiesManager.shared.retriveUserLoginData(){
            let obj_1 = ProfileModel(title: "First name", subTitle: login.data.firstName ?? "" )
            let obj_2 = ProfileModel(title: "Last name", subTitle: login.data.lastName ?? "")
            let obj_3 = ProfileModel(title: "Email", subTitle: login.data.email ?? "")
            let obj_4 = ProfileModel(title: "Phone", subTitle: login.data.mobileNo ?? "")
            arr.append(obj_1)
            arr.append(obj_2)
            arr.append(obj_3)
            arr.append(obj_4)

        }
        else if let register = UtilitiesManager.shared.retriveUserData(){
            let obj_1 = ProfileModel(title: "First name", subTitle: register.data.firstName )
            let obj_2 = ProfileModel(title: "Last name", subTitle: register.data.lastName )
            let obj_3 = ProfileModel(title: "Email", subTitle: register.data.email )
            let obj_4 = ProfileModel(title: "Phone", subTitle: register.data.mobileNo ?? "")
            arr.append(obj_1)
            arr.append(obj_2)
            arr.append(obj_3)
            arr.append(obj_4)

        }

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
