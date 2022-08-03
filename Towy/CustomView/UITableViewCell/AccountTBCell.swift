//
//  AccountTBCell.swift
//  Towy
//
//  Created by Usman on 29/07/2022.
//

import UIKit

class AccountTBCell: UITableViewCell {

    @IBOutlet weak var lblTitle:UILabel!
    @IBOutlet weak var img:UIImageView!
    var obj : AccountDataModel?{
        didSet{
            self.lblTitle.text = obj?.title ?? ""
            self.img.image = UIImage(named: obj?.img ?? "")
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
