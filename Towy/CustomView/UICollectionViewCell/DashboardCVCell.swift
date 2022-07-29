//
//  DashboardCVCell.swift
//  Towy
//
//  Created by Usman on 29/07/2022.
//

import UIKit

class DashboardCVCell: UICollectionViewCell {

    
    @IBOutlet weak var viewBackground : UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        viewBackground.backgroundColor = AppColor.appPrimaryColor
    }

}
