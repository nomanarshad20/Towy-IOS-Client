//
//  AccountSettingTBCell.swift
//  Towy
//
//  Created by Usman on 30/07/2022.
//

import UIKit

class AccountSettingTBCell: UITableViewCell {

    @IBOutlet weak var lblTitle : UILabel!
    @IBOutlet weak var lblSubtitle : UILabel!

    var obj : ProfileModel?{
        didSet{
            self.lblTitle.text = obj?.title ?? ""
            self.lblSubtitle.text = obj?.subTitle ?? ""
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
