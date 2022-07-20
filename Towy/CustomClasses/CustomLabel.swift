//
//  CustomLabel.swift
//  Towy
//
//  Created by Usman on 22/06/2022.
//

import Foundation
import UIKit





class CustomLabel:UILabel{
    
    func setMediumFont(size:CGFloat){
        self.font = UIFont(name: FontNames.UberMoveText.mediumFont, size: size)
    }
    func setBoldFont(size:CGFloat){
        self.font = UIFont(name: FontNames.UberMoveText.boldFont, size: size)
    }
    func setRegularFont(size:CGFloat){
        self.font = UIFont(name: FontNames.UberMoveText.regularFont, size: size)
    }
    
}



