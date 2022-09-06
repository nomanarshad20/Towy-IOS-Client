//
//  NewDashBoardCVCell.swift
//  Towy
//
//  Created by Usman on 03/08/2022.
//

import UIKit

class NewDashBoardCVCell: UICollectionViewCell {

    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var img : UIImageView!

    
    lazy var obj : VehicleType?  = nil {
        didSet{
            self.lblTitle.text = obj?.name ?? ""
            UtilitiesManager.shared.setImage(url: obj?.image ?? "", img: self.img)
            //self.img
            
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
