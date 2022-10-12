//
//  TextWithCheckboxTableViewCell.swift
//  Oyla Captain
//
//  Created by apple on 11/12/20.
//  Copyright © 2020 Cyber Advance Solutions. All rights reserved.
//

import UIKit
class TextWithCheckboxTableViewCell: UITableViewCell {
    
    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var imgStatus:UIImageView!
    
//    var cellType:CellType!
    var data:Precaution!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    /*
    override var isSelected: Bool{
        
        willSet{
            super.isSelected = newValue
            if newValue
            {
//                self.viewFolder.layer.borderWidth = 2
//                self.viewFolder.layer.borderColor = UIColor.red.cgColor
                imgStatus.image = UIImage.init(named: "check")

//                self.layer.borderWidth = 1.0
//                self.layer.cornerRadius = self.bounds.height / 2
//                self.layer.borderColor = UIColor.violetNeeoColor.cgColor
//                self.genreNameLabel.textColor = UIColor.violetNeeoColor
            }
            else
            {
                imgStatus.image = UIImage.init(named: "unCheck")

//                self.viewFolder.layer.borderWidth = 0
//                self.viewFolder.layer.borderColor = UIColor.clear.cgColor

//                self.layer.borderWidth = 0.0
//                self.layer.cornerRadius = 0.0
//                self.genreNameLabel.textColor = UIColor.white
            }
        }
    }
    
    */
    
    
   // func setData(data:Precaution)->TextWithCheckboxTableViewCell?{
        func setData(data:Precaution){

        self.lblTitle.text = data.text
        
//        self.imgStatus.image = UIImage.init(named: "unCheck")
//        if data.status ?? true{
//            
//        }else{
//            
//        }
//            self.lblTitle.font =  UIFont(name: "Montserrat-Medium", size: 15.0)!
//            return self
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    func changeStatus()->Precaution{
        if data.status!{
//            imgStatus.image = UIImage.init(named: "unCheck")
            data.status?.toggle()
        }else{
//            imgStatus.image = UIImage.init(named: "check")
            data.status?.toggle()
        }
        return data
    }
    
    
}

