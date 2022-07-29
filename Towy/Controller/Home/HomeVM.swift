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
    
    // MARK: - API_Handling
    
    
    
    
    // MARK: - Alert
    
  
    // MARK: - Validation
    
    
}
